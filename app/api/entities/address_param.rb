module API
  module Entities
    class AddressParam < Grape::Entity
      expose :street, documentation: { type: String, desc: 'Street of address.' }
      expose :number, documentation: { type: Integer, desc: 'Number of address.' }
      expose :city, documentation: { type: String, desc: 'City of address.' }
      expose :country, documentation: { type: String, desc: 'Country of address.', default: 'Brazil', values: ['Brazil', 'Portugal'] }
    end
  end
end