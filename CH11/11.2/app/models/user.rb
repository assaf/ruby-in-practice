require 'activeldap'

class User < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'uid', :prefix => 'cn=users',
               :classes => ['top','account']
  belongs_to :groups, :class => 'Group', :many => 'memberUid',
             :foreign_key => 'uid'
end