class Api::V1::AuthenticationsController < Api::V1::BaseController

  skip_before_action :authenticate_request

  def create
    user = User.by_lower_email(user_params[:email]).first
    if user.try(:authenticate, user_params[:password])
      render json: { token: JsonWebToken.encode({ user_id: user.id, exp: 1.week.from_now.to_i }), user_id: user.id }, status: :ok
    else
      render json: { errors: "Invalid email/password combination" }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
