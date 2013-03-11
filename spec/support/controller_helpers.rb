module ControllerHelpers
  def signed_in_user
    @signed_in_user ||= build_stubbed :user, :confirmed
  end

  def signed_in(user = nil)
    user ||= signed_in_user
    request.env['warden'].stub authenticate!: user
    controller.stub current_user: user
  end

  def signed_out
    request.env['warden'].stub(:authenticate!).and_throw(:warden, scope: :user)
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller

  config.before(signed_in: true) do
    signed_in
  end

  config.before(signed_out: true) do
    signed_out
  end
end
