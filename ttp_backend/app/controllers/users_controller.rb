class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token
  wrap_parameters :user, include: %i[name email_address password cash]

  def create
    user = User.new(userParams)
    if user.save
        token = encode_token(user.id)
        render json: {user: user, token: token}
    else
        render json: {errors: user.errors.full_messages}, status: :not_acceptable
    end
  end

  def index
    users = User.all
    render json: users
  end

  def update
    user = User.find_by(id: params[:id])
    user.update(userParams)
    render json: user
  end

  def signin
    user = User.find_by(email_address: params[:email_address])
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

end
