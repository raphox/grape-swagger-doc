module API
  class Base < Grape::API
    ## Global context ##############################################
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    ## Shared context ##############################################
    helpers do
      def current_user
        @current_user ||= ::User.first
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    ## Endpoint context ############################################
    resource :statuses do
      desc 'Returns your public timeline.', {
        detail: 'List all public status for all user of this API.',
        entity: API::Entities::Status,
        is_array: true,
        http_codes: [
          [500, "Cant load status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      get :public_timeline do
        present ::Status.limit(20), with: API::Entities::Status
      end

      desc 'Return a personal timeline.', {
        detail: 'List all personal status for current user of this API.',
        entity: API::Entities::Status,
        is_array: true,
        http_codes: [
          [401, "401 Unauthorized", API::Entities::Error],
          [500, "Cant load status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      get :home_timeline do
        authenticate!
        present current_user.statuses.limit(20), with: API::Entities::Status
      end

      desc 'Return a status.', {
        detail: 'Load a unique status from all users.',
        entity: API::Entities::Status,
        http_codes: [
          [400, "Status not found.", API::Entities::Error],
          [500, "Cant load status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      params do
        requires :id, type: Integer, desc: 'Status id.'
      end
      route_param :id do
        get do
          present ::Status.find(params[:id]), with: API::Entities::Status
        end
      end

      desc 'Create a status.', {
        entity: API::Entities::Status,
        http_codes: [
          [500, "Cant load status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      params do
        requires :status, type: Hash, desc: 'Your status.' do
          requires :all, except: [:user_id], using: API::Entities::StatusParam.documentation
        end
      end
      post do
        authenticate!
        present ::Status.create!({
          user_id: current_user.id,
          text: params[:status][:text]
        }), with: API::Entities::Status
      end

      desc 'Update a status.', {
        entity: API::Entities::Status,
        http_codes: [
          [400, "Status not found.", API::Entities::Error],
          [500, "Cant load status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      params do
        requires :id, type: String, desc: 'Status ID.'
        requires :status, type: Hash, desc: 'Your status.' do
          requires :all, except: [:user_id], using: API::Entities::StatusParam.documentation
        end
      end
      put ':id' do
        authenticate!
        current_user.statuses.find(params[:id]).update({
          user_id: current_user.id,
          text: params[:status][:text]
        })

        present current_user.statuses.find(params[:id]), with: API::Entities::Status
      end

      desc 'Delete a status.', {
        detail: 'Delete a unique status from current user.',
        entity: API::Entities::Status,
        http_codes: [
          [400, "Status not found.", API::Entities::Error],
          [500, "Cant load or delete status.", API::Entities::Error]
        ],
        headers: {
          'X-Token': {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      params do
        requires :id, type: String, desc: 'Status ID.'
      end
      delete ':id' do
        authenticate!
        present current_user.statuses.find(params[:id]).destroy, with: API::Entities::Status
      end
    end

    ## Global context ##############################################
    add_swagger_documentation(
      api_version: 'v1',
      format: :json,
      markdown: GrapeSwagger::Markdown::KramdownAdapter,
      info: {
        title: "Title of API",
        contact: "BRA-develop@conseur.org",
        # Using the README.rdoc file not to pollute the file.
        description: File.read(File.join(Rails.root, 'README.rdoc'))
      }
    )
  end
end