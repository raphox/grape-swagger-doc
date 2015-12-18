module API
  module Params::Status
    extend Grape::API::Helpers

    params :status do
      requires :text, type: String, desc: "Content of status."
      optional :user_id, type: Integer, desc: "Reference to user."

      optional :address, type: Hash, desc: "Object" do
        requires :street, type: String, desc: "Street of address."
        optional :number, type: Integer, desc: "Number of address."
        optional :city, type: String, desc: 'City of address.'
        optional :country, type: String, desc: 'Country of address.', default: 'Brazil', values: ['Brazil', 'Portugal']
      end
    end
  end
end