require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "./config/dictionary.db"
)

require_relative "../lib/user"
require_relative "../lib/saved_word"

