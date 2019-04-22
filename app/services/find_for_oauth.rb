class Services::FindForOauth

  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authoriation = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authoriation.user if authoriation

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_authorization(auth)
    end

    user
  end
end