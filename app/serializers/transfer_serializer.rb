class TransferSerializer < Panko::Serializer
  attributes :sender, :receiver, :deposit

  def deposit
    action = object.actions.find_by(type: ::Action::TRANSFER_TYPE)
    return nil unless action

    data = JSON.parse(action.data)
    deposit_value = data['deposit']
    return nil unless deposit_value

    # Near token is a currency with a scale factor of 24
    #   Eg. A sample deposit of 716669915088987500000000000 should be displayed as "716.6699150889875 NEAR"
    deposit_value.to_i / 10.0 ** 24
  end
end
