Rails.configuration.stripe = {
  :publishable_key => Rails.application.credentials.production[:stripe_publishable_key],

  :secret_key      => Rails.application.credentials.production[:stripe_secret_key]
 }
 Stripe.api_key =  Rails.application.credentials.production[:stripe_secret_key]