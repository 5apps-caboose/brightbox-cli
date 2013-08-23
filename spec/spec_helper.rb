__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), "..","lib"))

$LOAD_PATH.unshift __LIB_DIR__ unless
  $LOAD_PATH.include?(__LIB_DIR__) ||
  $LOAD_PATH.include?(File.expand_path(__LIB_DIR__))

require "brightbox_cli"
require "support/common_helpers"
require "tmpdir"

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

#API_CLIENT_CONFIG_DIR = File.join(File.dirname(__FILE__), "configs/api_client")
#USER_APP_CONFIG_DIR   = File.join(File.dirname(__FILE__), "configs/user_application")

#API_CLIENT_CONFIG = Brightbox::BBConfig.new(:directory => API_CLIENT_CONFIG_DIR)
#USER_APP_CONFIG   = Brightbox::BBConfig.new(:directory => USER_APP_CONFIG_DIR)

# These are the contents
API_CLIENT_CONFIG_CONTENTS = File.read(File.join(File.dirname(__FILE__), "configs/api_client.ini"))
USER_APP_CONFIG_CONTENTS = File.read(File.join(File.dirname(__FILE__), "configs/user_app.ini"))

# Remember the $HOME of the test runner
TEST_RUNNER_HOME = ENV["HOME"]

RSpec.configure do |config|
  config.include CommonHelpers
  config.include ConfigHelpers
  config.include TokenHelpers
  config.include PasswordPromptHelpers

  # For each test, isolate the testing users $HOME so that we control the config
  # and any cached values completely.
  config.around(:each) do |example|
    Dir.mktmpdir do |tmp_home|
      ENV["HOME"] = tmp_home

      # The horror continues since we have to scope the global to prevent any
      # code touching Api.conn from leaking out
      $config = config_from_contents(API_CLIENT_CONFIG_CONTENTS)
      example.run
      ENV["HOME"] = TEST_RUNNER_HOME
    end
  end
end
