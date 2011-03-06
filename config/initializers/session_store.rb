# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_photoroute_session',
  :secret      => '7b089222ee1a38449315b59451a77829d4336ef569d9f9c9dd1d9a223cb22a65af8682feb1728e736b79a6a755f888f42ab8680677b34d588e23436ba296449d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
