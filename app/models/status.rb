class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :address

  def replies
    Status.limit(10)
  end
end
