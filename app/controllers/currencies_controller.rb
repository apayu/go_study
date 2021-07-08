# frozen_string_literal: true

class CurrenciesController < AdminController
  def index
    @currencies = Currency.all
  end
end
