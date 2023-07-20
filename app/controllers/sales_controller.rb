# frozen_string_literal: true

# SalesController
class SalesController < ApplicationController
  def search
    # result = OrderSearch.new(params[:per_page], params[:page], params[:seller], params[:customer],
    #                         params[:start_date], params[:end_date], params[:product_code],
    #                         params[:city], params[:state]).search

    #@orders = JSON.parse(result.to_json)

    @orders, @per_page, @page = OrderSearch.new(params[:per_page], params[:page], params[:seller],
                                params[:customer], params[:start_date], params[:end_date], params[:product_code],
                                params[:city], params[:state]).search
  end
end
