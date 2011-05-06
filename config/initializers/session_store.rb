# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_maloshumos_session',
  :secret      => '92275b66229a0df12aa07fa0517680bcb547f6851a831ebb4ba3834a6f7d1a23c49712fc5a06e66b361c01ecefbeac2f5fa45c0aa75aa5edaa6f4227c3a1f277'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
