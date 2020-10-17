module OmniAuthHelpers
  def set_omniauth(service = :twitter)
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[service] = OmniAuth::AuthHash.new({
      provider: service.to_s,
      uid: '1234',
       info: {
         name: 'mock_user',
         email: 'mock@test.com',
         image: "https://www.tv-asahi.co.jp/doraemon/cast/img/doraemon.jpg"
       },
       credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      }
      })
  end
end