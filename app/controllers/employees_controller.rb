class EmployeesController < ApplicationController
    before_action :load_object!, only: [:show, :delete, :update]

    def index
        employees = Employee.all

        if params[:q].present?
            employees = employees.where(
                "LOWER(first_name) LIKE :q OR LOWER(last_name) LIKE :q",
                q: "%#{params[:q].downcase}%"
            )
        end

        if params[:gender].present?
            employees = employees.where(gender: params[:gender])
        end

        employees = employees.map do |employee|
            employee.to_h
        end

        render :json => employees
    end

    def update
        first_name      = params[:first_name]
        last_name       = params[:last_name]
        gender          = params[:gender]
        mobile_number   = params[:mobile_number]

        cmd = SaveEmployee.new(
            employee:       @employee,
            first_name:     first_name,
            last_name:      last_name,
            gender:         gender,
            mobile_number:  mobile_number
        )

        cmd.execute!

        if cmd.valid?
            render json: cmd.employee.to_h
        else
            render json: cmd.payload, status: :unprocessable_entity
        end
    end

    def create
        first_name      = params[:first_name]
        last_name       = params[:last_name]
        gender          = params[:gender]
        mobile_number   = params[:mobile_number]

        cmd = SaveEmployee.new(
            first_name:     first_name,
            last_name:      last_name,
            gender:         gender,
            mobile_number:  mobile_number
        )

        cmd.execute!

        if cmd.valid?
            render json: cmd.employee.to_h
        else
            render json: cmd.payload, status: :unprocessable_entity
        end
    end

    def show
        render json: {
            id: @employee.id,
            firstName: @employee.first_name,
            lastName: @employee.last_name,
            gender: @employee.gender,
            mobileNumber: @employee.mobile_number
        }
    end

    def delete
        @employee.destroy!

        render json: { message: 'ok' }
    end

    private

    def load_object!
        @employee = Employee.find_by_id(params[:id])

        if @employee.blank?
            render json: { message: 'not found' }, status: :not_found
        end
    end
end