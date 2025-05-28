class RatesController < ApplicationController
    before_action :load_employee!

    def index
        render json: @employee.rates.map do |rate|
            {
                id: rate.id,
                amount: rate.amount,
                date_effect: rate.try(:strftime, "%B %d, %Y")
            }
        end
    end

    def create
        rate = Rate.new(
            employee: @employee,
            amount: params[:amount],
            date_effect: params[:date_effect]
        )

        rate.save!

        render json: @employee.rates.map |rate| do 
            {
                id: rate.id,
                amount: rate.amount,
                date_effect: rate.try(:strftime, "%B %d, %Y")
            }
        end
    end

    private

    def load_employee!
        @employee = Employee.find(params[:employee_id])
    end
end