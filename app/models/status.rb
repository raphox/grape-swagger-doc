class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :address

  accepts_nested_attributes_for :address

  def replies
    Status.limit(10)
  end
end
