module Brightbox
  module Config
    module Cache
      def cache_path
        if @cache_path
          @cache_path
        else
          @cache_path = File.join(config_directory, 'cache')
          unless File.exists? @cache_path
            begin
              FileUtils.mkpath @cache_path
            rescue Errno::EEXIST
            end
          end
          @cache_path
        end
      end

      def save_default_account(account_id)
        selected_config['default_account'] = account_id
      end

      def cache_id(cid)
        FileUtils.touch(File.join(cache_path, cid)) unless cid.nil?
      end

    end
  end
end
