module API
  module Entities
    class Status < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :username, documentation: { type: String, desc: "Username of user that created this status." }
      expose :text, documentation: { type: String, desc: "Status update text." }
      expose :ip, documentation: { type: String, desc: "IP used by user when created this status." }, if: { type: :full }
      expose :user_id, documentation: { type: Integer, desc: "User infos." }

      expose :contact_info do
        expose :phone, documentation: { type: String, desc: "Phone number of contact." }
        expose :address, using: API::Entities::Address,
          documentation: { type: API::Entities::Address, desc: "Address of contact.", is_array: false }
      end
      
      expose :digest, documentation: { type: String, desc: "MD5 for current status." } do |status, options|
        Digest::MD5.hexdigest status.text rescue nil
      end
      
      # ATTENTION: In this relationship and `last_replay` you cant use recurse class because generate a infinity loop.
      # So you use a outher class that extend this current class without relationships.
      expose :replies, using: API::Entities::StatusReply,
        documentation: { type: API::Entities::StatusReply, desc: "Replies for current status.", is_array: true }

      expose :last_reply, using: API::Entities::StatusReply,
        documentation: { type: API::Entities::StatusReply, desc: "Last reply for current status.", is_array: false } do |status, options|
        status.replies.last
      end

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: Time, desc: "Status was created at." }
        expose :updated_at, documentation: { type: Time, desc: "Status was updated at." }
      end
    end
  end
end