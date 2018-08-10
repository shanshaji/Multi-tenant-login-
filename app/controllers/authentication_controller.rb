class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
        ::SwitchTenant.switch_subdomain(request.headers['Subdomain'])
        command = AuthenticateUser.call(user_params)
        if command.success?
            render json: { auth_token: command.result[:token], user: {type: command.result[:role], name: command.result[:name], email: command.result[:email]}, status: {msg: "Successfully logged in", info: "Success"} }
        else
            render json: {errors: {msg:["Invalid email or password"]}, action: "SIGN_IN"} , status: :unauthorized
        end
    end
end

private

def user_params
    params.require(:user).permit(:email, :password)
end