module API
  module Utils
    class ErrorsHandler
      def self.payload
        {
          remote_addr:    env['REMOTE_ADDR'],
          request_method: env['REQUEST_METHOD'],
          request_path:   env['PATH_INFO'],
          request_query:  env['QUERY_STRING'],
          x_organization: env['HTTP_X_ORGANIZATION']
        }
      end

      def self.genericError(e)
        self.logger(e, { message: e.message, details: e.backtrace }, 500)
      end

      def self.notFoundError(e)
        self.logger(e, { message: e.message }, 404)
      end

      def self.validationErrors(e)
        self.logger(e, { message: e.message, details: e.errors }, e.status)
      end

      def self.sqlError(e)
        self.logger(e, { message: e.message }, 400)
      end

      def self.logger(e, error, status)
        Rails.logger.debug(e)

        Rack::Response.new({ code: e.class.name, success: false }.merge(error).to_json, status, { 'Content-Type' => 'application/json' })
      end
    end
  end
end