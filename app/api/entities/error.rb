module API
  module Entities
    class Error < Grape::Entity
      expose :code, documentation: { type: String, desc: 'Class name or code of error.' }
      expose :message, documentation: { type: String, desc: 'Summary of the problem.' }
      expose :details, documentation: { type: String, desc: 'Details about the problem.' }

      expose :success, documentation: { type: 'boolean', desc: 'False to represent fail in the request.' }

      def code
        object[:code]
      end

      def message
        object[:message]
      end

      def details
        object[:details]
      end

      def success
        false
      end
    end
  end
end
