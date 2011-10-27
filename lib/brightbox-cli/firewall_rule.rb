module Brightbox
  class FirewallRule < Api
    attr_writer :attributes

    def self.create(options)
      new(conn.firewall_rules.create(options))
    end

    def self.get(id)
      conn.firewall_rules.get(id)
    end

    def attributes
      t = @attributes || fog_model.attributes
      t[:sport] = t[:source_port]
      t[:dport] = t[:destination_port]
      t[:firewall_policy] = t[:firewall_policy_id]
      t[:icmp_type] = t[:icmp_type_name]
      t
    end

    def to_row
      attrs = attributes
      attrs[:protocol] = attributes[:protocol] || '-'
      attrs[:source]   = attributes[:source] || '-'
      attrs[:sport]    = attributes[:sport] || '-'
      attrs[:destination] = attributes[:destination] || '-'
      attrs[:dport]    = attributes[:dport] || '-'
      attrs[:icmp_type] = attributes[:icmp_type] || '-'
      attrs
    end

    def self.default_field_order
      [:id, :protocol,:source, :sport,:destination, :dport, :icmp_type]
    end
  end
end
