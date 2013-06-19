module Fog
  module Compute
    class Brightbox
      class Real
        # Shows details of one collaboration
        #
        # @param [String] identifier Unique reference to identify the resource
        #
        # @return [Hash] The JSON response parsed to a Hash
        #
        # @see https://api.gb1.brightbox.com/1.0/#collaboration_get_collaboration
        #
        def get_collaboration(identifier)
          return nil if identifier.nil? || identifier == ""
          request("get", "/1.0/collaborations/#{identifier}", [200])
        end

      end
    end
  end
end