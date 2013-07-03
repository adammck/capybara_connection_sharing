ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Roll back the database after each test
  self.use_transactional_fixtures = true
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end

Capybara.default_driver = :poltergeist

unless $patched
  unless ENV["PATCH"].present?
    puts "Specify which monkey-patch to use with the PATCH var."
    puts "Try one of:"
    puts
    puts "$ bundle exec rake test:all PATCH=none"
    puts "$ bundle exec rake test:all PATCH=capybara"
    puts "$ bundle exec rake test:all PATCH=mperham"
    exit!
  end

  case ENV["PATCH"]
  when "none"
    puts "Not monkey-patching"

  when "capybara"
    puts "Applying Capybara monkey-patch"
    puts "See: https://github.com/jnicklas/capybara#transactions-and-database-setup"

    class ActiveRecord::Base
      mattr_accessor :shared_connection
      @@shared_connection = nil

      def self.connection
        @@shared_connection || retrieve_connection
      end
    end
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  when "mperham"
    puts "Applying @mperham's monkey-patch"
    puts "See: https://gist.github.com/mperham/3049152"

    class ActiveRecord::Base
      mattr_accessor :shared_connection
      @@shared_connection = nil

      def self.connection
        @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
      end
    end
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  end

  $patched = true
  puts "----"
  puts
end
