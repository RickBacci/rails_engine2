class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.all.sample
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def revenue
    if params[:date]
      respond_with ({ revenue: Merchant.find(params[:id]).revenue(params[:date]) })
    else
      respond_with ({ revenue: Merchant.find(params[:id]).revenue })
    end
  end

  def most_revenue
    respond_with ( Merchant.most_revenue(params[:quantity]))
  end

  def date_revenue
    respond_with ({ total_revenue: Merchant.total_revenue_by_date(params[:date]) } )
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def most_items
    respond_with ( Merchant.most_items(params[:quantity]))
  end

  def pending_invoices
    respond_with Merchant.find(params[:id]).pending_invoices
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at)
  end
end

