module API
  module Entities
    class StatusParam < Grape::Entity
      expose :text, documentation: { type: String, desc: "Status update text.", required: true }
      expose :user_id, documentation: { type: Integer, desc: "User infos." }

      expose :addresses, using: API::Entities::AddressParam,
        documentation: { type: API::Entities::AddressParam, desc: 'Addresses.', param_type: 'body', is_array: false }
    end
  end
end