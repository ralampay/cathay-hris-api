class SaveEmployee < Validator
    attr_reader :employee

    def initialize(employee: nil, first_name:, last_name:, gender:, mobile_number:)
        super()

        @employee = employee

        if @employee.blank?
            @employee = Employee.new
        end

        @first_name     = first_name
        @last_name      = last_name
        @gender         = gender
        @mobile_number  = mobile_number

        @payload = {
            first_name:     [],
            last_name:      [],
            gender:         [],
            mobile_number:  []
        }

        @count = 0
    end

    def execute!
        validate!
        count_errors!

        if self.valid?
            @employee.first_name    = @first_name
            @employee.last_name     = @last_name
            @employee.gender        = @gender
            @employee.mobile_number = @mobile_number

            @employee.save
        end
    end

    private

    def validate!
        if @employee.new_record?
            # Validate for new record
            if @first_name.blank?
                @payload[:first_name] << "required"
            end

            if @last_name.blank?
                @payload[:last_name] << "required"
            end

            if @gender.blank?
                @payload[:gender] << "required"
            elsif !Employee::GENDERS.includes?(@gender)
                @payload[:gender] << "invalid value"
            end

            if @mobile_number.blank?
                @payload[:mobile_number] << "required"
            elsif !validate_mobile_number(@mobile_number)
                @payload[:mobile_number] << "invalid format"
            elsif Employee.find_by_mobile_number(@mobile_number).present?
                if @first_name.present? and @last_name.present?
                    existing_employee = Employee.where(
                        first_name: @first_name,
                        last_name: @last_name,
                        mobile_number: @mobile_number
                    ).first

                    if existing_employee.present?
                        @payload[:mobile_number] << "already taken by employee #{existing_employee.id}"
                    end
                end
            end
        else
            # Validate for existing record
            if @mobile_number.present?
                if @first_name.present? and @last_name.present?
                    existing_employee = Employee.where(
                        first_name: @first_name,
                        last_name: @last_name,
                        mobile_number: @mobile_number
                    ).first

                    if existing_employee.present?
                        @payload[:mobile_number] << "already taken by employee #{existing_employee.id}"
                    end
                end
            end
        end
    end

    def validate_mobile_number(mobile_number)
        pattern = /\A9\d{9}\z/

        mobile_number.match?(pattern)
    end
end
