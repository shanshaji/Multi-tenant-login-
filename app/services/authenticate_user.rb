class AuthenticateUser
    prepend SimpleCommand
    def initialize user
        @email = user[:email]
        @password = user[:password]
    end

    def call
        if user.present?
            token = JsonWebToken.encode(user_id: user.id)
            {token: token, user_name: user.user_name, email: user.email}
        else
            nil
        end
    end

    private

    attr_accessor :email, :password

    def user
        user = User.find_by_email(email)
        return user if user && user.authenticate(password)
        errors.add :user_authentication, 'invalid credentials'
        nil
    end
end