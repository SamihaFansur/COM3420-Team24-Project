## Application deployment configuration
set :server,      'epi-stu-hut-demo4.shef.ac.uk'
set :user,        'demo.team24'
set :deploy_to,   -> { "/srv/services/#{fetch(:user)}" }
set :log_level,   :debug
set :rails_env,   :demo

## Server configuration
server fetch(:server), user: fetch(:user), roles: %w{web app db}

## Additional tasks
namespace :deploy do
  task :seed do
    on primary :db do within current_path do with rails_env: fetch(:stage) do
      execute :rake, 'db:seed'
    end end end
  end
end