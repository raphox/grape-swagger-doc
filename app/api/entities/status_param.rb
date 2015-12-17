module API
  module Entities
    class StatusParam < Grape::Entity
      expose :text, documentation: { type: String, desc: "Status update text." }
      expose :user_id, documentation: { type: Integer, desc: "User infos." }
    end
  end
end