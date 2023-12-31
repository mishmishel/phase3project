require 'active_record'
require 'colorize'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "./config/dictionary.db"
)

require_relative "../lib/user"
require_relative "../lib/dictionary_api"

