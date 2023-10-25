require 'net/http'
require 'open-uri'
require 'json'

class DictionaryAPI 
    BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"

    def self.get_word(name)
        uri = URI.parse(BASE_URL + name)
        response = Net::HTTP.get_response(uri)

        if response.kind_of? Net::HTTPSuccess
            json = JSON.parse(response.body)

            if json.is_a?(Array) && json.first.is_a?(Hash)
                word = {
                  name: json.first["word"],
                  meanings: json.first["meanings"],
                  synonyms: json.first["synonyms"]
                }
                return word
            end
            else
            {}
        end
    end
end


