module ApiAuthentication
  extend ActiveSupport::Concern
  included { attr_reader :current_user }
  private
  def authenticate_user!
    token = request.headers["Authorization"].to_s.delete_prefix("Bearer ").presence
    return render_unauthorized unless token
    payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256").first
    @current_user = User.find_by(id: payload["sub"])
    render_unauthorized unless @current_user
  rescue JWT::DecodeError
    render_unauthorized
  end
  def issue_token(user)
    JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i, iat: Time.current.to_i }, Rails.application.secret_key_base, "HS256")
  end
end
