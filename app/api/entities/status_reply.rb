module API
  module Entities
    class StatusReply < API::Entities::Status
      unexpose :replies
      unexpose :last_reply
    end
  end
end