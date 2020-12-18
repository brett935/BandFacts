class Search < ApplicationRecord
    validates :searched_name, presence: true
    validates :success, presence: true
    validates :response, presence: false
end
