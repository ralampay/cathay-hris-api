class Employee < ApplicationRecord
    GENDERS = ["M", "F"]

    has_many :rates

    def to_h
        {
            id: self.id,
            firstName: self.first_name,
            lastName: self.last_name,
            gender: self.gender,
            mobileNumber: self.mobile_number
        }
    end
end
