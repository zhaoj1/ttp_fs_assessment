class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    user = User.new(userParams)
    if user.save
        token = encode_token(user.id)
        render json: {user: user, token: token}
    else
        render json: {errors: user.errors.full_messages}
    end
  end

  def signin
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        token = encode_token(user.id)
        render json: {user:user, token:token}
    else
        render json: {errors: "Username or password incorrect."}
    end
  end

private

    def userParams
      params.require(:user).permit(:name, :password, :email_address, :cash)
    end

    def user_params_with_args(*args)
      params.require(:user).permit(*args)
    end

end
