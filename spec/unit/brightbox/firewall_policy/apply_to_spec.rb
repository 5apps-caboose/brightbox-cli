require "spec_helper"

describe Brightbox::FirewallPolicy do

  describe "#apply_to" do
    use_vcr_cassette('apply_firewall_policy')

    it "should apply firewall policy" do
      lambda {
        params = { :name => "rspec_tests_apply"}
        group = Brightbox::ServerGroup.create(params)
        firewall_options = {
          :name => "rspec_firewall_policy_apply"
        }
        firewall_policy = Brightbox::FirewallPolicy.create(firewall_options)
        firewall_policy.apply_to(group.id)
        group.destroy
      }.should_not raise_error
    end
  end
end
