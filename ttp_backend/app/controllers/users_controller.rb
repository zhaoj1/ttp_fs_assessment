class UsersController < ApplicationController

  def create
    user = User.new(userParams)
    if user.save
        token = encode_token(user.id)
        render json: {user: user, token: token}
    else
        render json: {errors: user.errors.full_messages}, status: :not_acceptable
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        token = encode_token(user.id)
        render json: {user:user, token:token}
    else
        render json: {errors: "Username or password incorrect."}
    end
  end

private

    def userParams
        params.require(:user).permit(:name, :password, :email, :cash)
    end

end
