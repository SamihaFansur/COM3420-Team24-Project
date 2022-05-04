require 'rack-cas/session_store/rails/active_record'
Rails.application.config.session_store ActionDispatch::Session::RackCasActiveRecordStore, key: (if Rails.env.production?
                                                                                                  '_team24_session_id'
                                                                                                else
                                                                                                  (Rails.env.demo? ? '_team24_demo_session_id' : '_team24_dev_session_id')
                                                                                                end),
                                                                                          secure: (Rails.env.demo? || Rails.env.production?),
                                                                                          httponly: true
