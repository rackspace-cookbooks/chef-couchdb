require 'chef/provider'
require_relative 'helpers'

class Chef
  class Provider
    class CouchdbUser < Chef::Provider::CouchdbBase
      include Couchdb::Helpers

      def load_current_resource
        @current_resource ||= Chef::Resource::CouchdbUser.new(new_resource.name)
        @current_resource
      end

      def action_create
        ## TODO: Implement
      end

      def action_delete
        ## TODO: Implement
      end

      def exist?
        ## TODO: Implement
      end
    end
  end
end
