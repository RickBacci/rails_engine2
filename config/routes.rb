Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json } do


      categories = ['merchants', 'invoices',
                    'items', 'invoice_items',
                    'customers', 'transactions']

      categories.each do |category|
        get "/#{category}/find_all", to: "#{category}#find_all"
        get "/#{category}/random",   to: "#{category}#random"
        get "/#{category}/:id",      to: "#{category}#show", constraints: { id: /\d+/ }
        get "/#{category}/find",     to: "#{category}#find"
        get "/#{category}",          to: "#{category}#index"
      end


      get '/merchants/:id/items',        to: 'merchants#items'
      get '/merchants/:id/invoices',     to: 'merchants#invoices'
      get '/merchants/:id/revenue',      to: 'merchants#revenue'
      get '/merchants/most_revenue',     to: 'merchants#most_revenue'
      get '/merchants/revenue',          to: 'merchants#date_revenue'
      get '/merchants/:id/favorite_customer', to: 'merchants#favorite_customer'
      get '/merchants/most_items',       to: 'merchants#most_items'
      get '/merchants/:id/customers_with_pending_invoices', to: 'merchants#pending_invoices'

      get '/invoices/:id/transactions',  to: 'invoices#transactions'
      get '/invoices/:id/invoice_items', to: 'invoices#invoice_items'
      get '/invoices/:id/items',         to: 'invoices#items'
      get '/invoices/:id/customer',      to: 'invoices#customer'
      get '/invoices/:id/merchant',      to: 'invoices#merchant'

      get '/invoice_items/:id/invoice',  to: 'invoice_items#invoice'
      get '/invoice_items/:id/item',     to: 'invoice_items#item'

      get '/items/:id/invoice_items',     to: 'items#invoice_items'
      get '/items/:id/merchant',          to: 'items#merchant'

      get '/transactions/:id/invoice',   to: 'transactions#invoice'

      get '/customers/:id/invoices',     to: 'customers#invoices'
      get '/customers/:id/transactions', to: 'customers#transactions'
    end
  end
end
