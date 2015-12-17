module API
  module Entities
    class Success < Grape::Entity
      expose :success, documentation: { type: 'boolean', desc: 'True to represent success in the request.' }
      expose :message, documentation: { type: String, desc: 'Name of user.' }

      def success
        true
      end
    end
  end
end