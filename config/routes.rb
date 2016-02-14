Rails.application.routes.draw do
  get "404", to: "errors#not_found"
  get "422", to: "errors#not_permitted"
  get "500", to: "errors#server_error"

  root "pages#home"
  get "filter-list", to: "pages#filter_list"

  # Used with error routing, must remain last in sort order.
  fallback_options = Rails.env.development? ? { unmatched_route: %r{(?!.*rails/mailers).*} } : {}
  get "*unmatched_route", fallback_options.merge(to: "application#raise_not_found!")
end
