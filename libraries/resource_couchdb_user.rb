## Creates a normal user org.couchdb.user or creates an admin
## user
require_relative 'resource_couchdb_base'

class Chef
  class Resource
    class CouchdbUser < Chef::Resource::CouchdbBase

      def initialize(name, run_context=nil)
        super
        @resource_name = :couchdb_user
        @provider = Chef::Provider::CouchdbConfig
        @action = :create
        @allowed_actions  = [:create, :delete]
      end

      def username(arg=nil)
        set_or_return(:username,
                      arg,
                      kind_of: String,
                      required: true)
      end

      def password(arg=nil)
        set_or_return(:password,
                      arg,
                      kind_of: String,
                      required: true)
      end

      ## Only applicable if non admin user
      def roles(arg=nil)
        set_or_return(:roles,
                      arg,
                      kind_of: Array,
                      default: [])
      end

      def admin(arg=nil)
        set_or_return(:admin,
                      arg,
                      kind_of: [TrueClass, FalseClass],
                      default: false)
      end
    end
  end
end
