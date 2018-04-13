require_relative 'boot'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Giant
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    WillPaginate.per_page = 30
    ENV['RAILS_MASTER_KEY'] = 'GEzpAKyqk0cntt/T9eQngHprg2ieDcbORSIhrKlnofz8aXZSkPoHrWA2rIzINVRdwtgHsXQ1XkA0m+lXSVx/doe0+aBFUTULFrDI6MVp5vymY/i9SqvWnUUxYjfxfep5ZbkyiUiADuW+9001woUyMZte6zgd/bUZfjBVFVu/hD10I1ax3/c97vI/WcfV77geum07ixrKeQgR/wcEF2JNVIf+g11yp5h6N0jR6W/F6wRqlH9qtkMat+7KDI6SYw7D0Q7Kv2mDFRo9PkS/GhnwUewxeZA2h57QjnyDIno6efxAdq+WVNrUHmYh8qnQlhX8ma2aPZIAtttYiFbVBBcPEZDuqp5BGhzs3g1ffPGBGWmxgZWh7tnptEhymzJKtcSRN4T+x6xLxeijLC5oeETm0xFyqiwf6+vrYlcjbZiT303vo3jIXRZXVo2diHm+Nw0r2S7Y3rakkhoRs7NUYBuYdYv+q1euX3fYBNioAgoExipkGuhorFni38JPEsyQnBYHTeCFpdVLARyRr4BapM4FG0/GVEIuXXLQ4ifrMz38JVrSlIlcifL4WHgZUavAt727hjCfdzyAOL39jZEPTPFYFvr5H6ARhvHDVBHohcSxijj3JTMKxCvwABH2JmALHAmmYHqdNOX364XdpdxYIwqLiUpdh1BcN57ZWgMHOjHukF+afvqrGSoMUBcqOQujpp0VaW+S2PkiIKBHj2K9CFA6dFhjikmW6rapoVFM9H9hW/geQOB+agD97VJHwe31aMhyt6Yjo0PNSfXSlmrZtCrEyQhDUNjh/bTIC2ZMnmcAkKyAmO2anDcfHh99dqYEeq5KA9tmTBE5LggvPmXhGO05OTg=--v2nMIucrtGeoJCrY--JEtkpYRnDOOkcD83DPVxZg=='
    config.before_configuration do
      # env_file = File.join(Rails.root, 'config', 'env.yml')
      # YAML.load(File.open(env_file)).each do |key, value|
      #   ENV[key.to_s] = value
      # end if File.exists?(env_file)
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    config.active_job.queue_adapter = :resque

  end
end
