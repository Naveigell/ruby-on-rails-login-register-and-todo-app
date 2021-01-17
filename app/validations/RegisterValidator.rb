class RegisterValidator
    include ActiveModel::Validations

    validates :username, length: {minimum: 4, too_short: "Username character minimum 4"}
    validates :email, length: {minimum: 4, too_short: "Email character minimum 4"}
    validates :password, length: {minimum: 4, too_short: "Password character minimum 4"}

    def username
        @username
    end
    def email
        @email
    end
    def password
        @password
    end

    def initialize(email, password, username)
        @username = username
        @email = email
        @password = password
    end
end
