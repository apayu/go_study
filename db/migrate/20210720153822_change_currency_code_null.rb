class ChangeCurrencyCodeNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :currencies, :code, true
  end
end
