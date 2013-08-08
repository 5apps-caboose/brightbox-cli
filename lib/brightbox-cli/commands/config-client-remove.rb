module Brightbox
  command [:config] do |cmd|

    cmd.desc "Remove api client details from config"
    cmd.arg_name "alias"
    cmd.command [:client_remove] do |c|

      c.action do |global_options, options, args|

        info "Using config file #{$config.config_filename}"

        calias = args.shift

        if calias.nil?
          raise "You must specify the api alias you want to remove"
        end

        client_config = $config.clients.detect{|c| $config[c]["alias"] == calias}
        if client_config.nil?
          raise "An api client with the alias #{calias} does not exist in the config"
        end

        info "Removing api client #{calias}"
        $config.delete_section client_config
      end
    end
  end
end
