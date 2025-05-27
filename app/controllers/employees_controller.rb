class EmployeesController < ApplicationController
    before_action :load_object!, only: [:show, :delete]

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
            {
                id: employee.id,
                firstName: employee.first_name,
                lastName: employee.last_name,
                gender: employee.gender,
                mobileNumber: employee.mobile_number
            }
        end

        render :json => employees
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