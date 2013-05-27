module Brightbox
  extend GLI::App

  sort_help :manually
  version Brightbox::VERSION

  # Global options
  desc "Simple output (tab separated, don't draw fancy tables)"
  switch [:s, :simple], :negatable => false

  desc "Set the api client to use (named in #{CONFIG.config_filename})"
  flag [:c, :client]

  desc "Set the account to use"
  flag :account

  desc "Disable peer SSL certificate verification"
  switch [:k, :insecure], :negatable => false

  # Load the command libraries for the current group
  cmd_group_name = File.basename($0).gsub(/brightbox\-/, '')
  cmd_group_files = File.join(File.dirname(__FILE__), "commands/#{cmd_group_name}*.rb")
  Dir.glob(cmd_group_files).each do |f|
    load f
  end

  pre do |global_options, command, options, args|
    CONFIG.client_name = ENV["CLIENT"] if ENV["CLIENT"]
    CONFIG.client_name = global_options[:c] if global_options[:c]
    CONFIG.account = ENV["ACCOUNT"] if ENV["ACCOUNT"]
    CONFIG.account = global_options[:account] if global_options[:account]

    Excon.defaults[:headers]['User-Agent'] = "brightbox-cli/#{Brightbox::VERSION} Fog/#{Fog::VERSION}"

    Excon.defaults[:headers]['User-Agent'] ||= "brightbox-cli/#{Brightbox::VERSION}"

    if global_options[:k] or ENV["INSECURE"]
      Excon.defaults[:ssl_verify_peer] = false
    end

    unless global_options[:s]
      Hirb.enable
      Hirb::View.resize
    end

    config_alias = CONFIG.alias == CONFIG.client_name ? nil : "(#{CONFIG.alias})"
    info "INFO: client_id: #{CONFIG.client_name} #{config_alias}" if CONFIG.clients.size > 1
    true
  end

  on_error do |e|
    ErrorParser.new(e).pretty_print()
    debug e
    debug e.class.to_s
    debug e.backtrace.join("\n")
    exit 1
  end
end
