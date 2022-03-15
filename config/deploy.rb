## Application configuration
set :application, 'project'
set :branch,                  -> { fetch(:stage) }
set :repo_url,    'git@git.shefcompsci.org.uk:com3420-2021-22/team24/project.git'
set :linked_files,            fetch(:linked_files,  fetch(:env_links, [])).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs,             fetch(:linked_dirs, []).push('log', 'tmp/pids', 'uploads')
# set the locations to look for changed assets to determine whether to precompile
set :assets_dependencies,     %w(app/assets lib/assets vendor/assets)
set :branch,                  -> { fetch(:stage) }

## Ruby configuration
set :rvm_type,                    :system
set :rvm_ruby_version,            'ruby-2.7.4'
set :rvm_path,                    '/usr/local/rvm'

# Currently Passenger is installed against the 'default' Ruby version
# This may change in future, but can be customised here
set :passenger_rvm_ruby_version,  'default'

## Capistrano configuration
set :log_level,               :info
set :pty,                     true
set :keep_releases,           2

## Whenever configuration
set :whenever_command,        [:bundle, :exec, :whenever]
set :whenever_roles,          [:db]
set :whenever_environment,    -> { (fetch(:rails_env) || fetch(:stage)) }
set :whenever_identifier,     -> { "#{fetch(:application)}-#{fetch(:whenever_environment)}" }
set :whenever_variables,      -> { "\"environment=#{fetch(:whenever_environment)}&delayed_job_args_p=#{fetch(:delayed_job_identifier)}&delayed_job_args_n=#{fetch(:delayed_job_workers)}\"" }

## Delayed Job configuration
set :delayed_job_roles,       [:db]
set :delayed_job_environment, -> { (fetch(:rails_env) || fetch(:stage)) }
set :delayed_job_identifier,  -> { "#{fetch(:application)}-#{fetch(:delayed_job_environment)}" }
set :delayed_job_workers,     -> { (fetch(:dj_workers) || '1') }
set :delayed_job_args,        -> { "-p #{fetch(:delayed_job_identifier)} -n #{fetch(:delayed_job_workers)}" }

namespace :delayed_job do

  def args
    fetch(:delayed_job_args, '')
  end

  def delayed_job_roles
    fetch(:delayed_job_roles, :db)
  end

  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', :stop
        end
      end
    end
  end

  desc 'Start the delayed_job process'
  task :start do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :start
        end
      end
    end
  end

  desc 'Restart the delayed_job process'
  task :restart do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :restart
        end
      end
    end
  end
end

# clear the previous precompile task so it can be reconfigured below
Rake::Task["deploy:assets:precompile"].clear_actions
# define a custom error used to trigger precompilation when required
class PrecompileRequired < StandardError; end

namespace :deploy do
  namespace :assets do
    task :precompile do
      on roles(:app) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            begin
              # find the most recent release
              latest_release = capture(:ls, '-xr', releases_path).split[1]

              # precompile if this is the first deploy
              raise PrecompileRequired unless latest_release

              latest_release_path = releases_path.join(latest_release)

              # precompile if the previous deploy failed to finish precompiling
              execute(:ls, latest_release_path.join('assets_manifest_backup')) rescue raise(PrecompileRequired)

              fetch(:assets_dependencies).each do |dep|
                # execute raises if there is a diff
                execute(:diff, '-Naur', release_path.join(dep), latest_release_path.join(dep)) rescue raise(PrecompileRequired)
              end

              info("Skipping asset precompilation because there were no asset changes")
            rescue PrecompileRequired
              execute :bundle, :exec, :rake, 'assets:precompile'
            end
          end
        end
      end
    end
  end

  ## Capistrano has removed the task deploy:migrations which epiDeploy calls
  task :migrations do
    invoke 'deploy'
  end

  ## Fix the Gemfile.lock file if deploying from Windows
  after :updating, :fix_bundler do
    on roles(:app) do
      within release_path do
        ## Remove any platform specific version strings
        execute :sed, '-ie', "'s/-x86-mingw32//'", 'Gemfile.lock', raise_on_non_zero_exit: false
        execute :sed, '-ie', "'s/-x64-mingw32//'", 'Gemfile.lock', raise_on_non_zero_exit: false
      end
    end
  end

  ## Fix the permissions on the bin folder
  after :updating, :fix_bin_perms do
    on roles(:app) do
      within release_path do
        execute :chmod, '+x', 'bin/*', raise_on_non_zero_exit: false
      end
    end
  end
end

## Restart delayed_job during the deployment process
after  'deploy:updated', 'delayed_job:stop'
before 'deploy:finished', 'delayed_job:start'