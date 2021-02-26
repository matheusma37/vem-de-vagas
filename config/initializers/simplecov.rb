if Rails.env.test?
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter '/storage'
    add_filter 'app/assets'
    add_filter 'app/channels'
    add_filter 'app/javascript'
    add_filter 'app/jobs'
    add_filter 'app/mailers'
  end
end
