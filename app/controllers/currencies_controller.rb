# frozen_string_literal: true

class CurrenciesController < AdminController
  before_action :find_currency, only: %i[edit update destroy]

  def index
    @currencies = Currency.all
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)

    if @currency.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @currency.update(currency_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @currency.destroy
    redirect_to root_path
  end

  private

  def currency_params
    params.require(:currency).permit(:code)
  end

  def find_currency
    @currency = Currency.find(params[:id])
  end
end
