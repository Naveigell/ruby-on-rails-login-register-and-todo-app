class TodoValidator
    include ActiveModel::Validations

    validates :title, length: {minimum: 4, too_short: "Title character minimum 4"}
    validates :description, length: {minimum: 4, too_short: "Description character minimum 4"}

    def title; @title; end
    def description; @description; end

    def initialize(title, description)
        @title = title
        @description = description
    end
end
