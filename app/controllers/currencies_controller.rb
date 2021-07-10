# frozen_string_literal: true

class CurrenciesController < AdminController
  def index
    @currencies = Currency.all
  end

  def new
    @new_currency = Currency.new
  end

  def create
    @new_currency = Currency.new(currency_params)

    if @new_currency.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def currency_params
    params.require(:currency).permit(:code)
  end
end
