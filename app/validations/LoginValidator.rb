class LoginValidator
    include ActiveModel::Validations

    validates :email, length: {minimum: 4, too_short: "Email character minimum 4"}
    validates :password, length: {minimum: 4, too_short: "Password character minimum 4"}

    def email
        @email
    end
    def password
        @password
    end

    def initialize(email, password)
        @email = email
        @password = password
    end
end
