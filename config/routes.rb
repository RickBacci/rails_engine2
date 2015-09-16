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

      get '/invoices/:id/transactions',  to: 'invoices#transactions'
      get '/invoices/:id/invoice_items', to: 'invoices#invoice_items'
      get '/invoices/:id/items',         to: 'invoices#items'
      get '/invoices/:id/customer',      to: 'invoices#customer'
      get '/invoices/:id/merchant',      to: 'invoices#merchant'

      get '/invoice_items/:id/invoice',  to: 'invoice_items#invoice'
      get '/invoice_items/:id/item',  to: 'invoice_items#item'
    end
  end
end
