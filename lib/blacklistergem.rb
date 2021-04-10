# frozen_string_literal: true

require_relative "blacklistergem/version"
require 'yaml' # require the yaml file to be read in

module Blacklistergem
  class Error < StandardError; end

  class Base
    class << self # assign class to itself so self does not need to be used for every method

      def blacklist
        @blacklist ||= YAML.load_file(File.expand_path("blacklist.yml", __dir__)) # load the yml file containing the blacklisted words and assign it to blacklist variable
      end

      def sanitize(input = "sassy") # method to take in user input to check for profanity
        word = input.downcase # set user input to downcase case to consistency
        blacklist.each do |key, value| # for each word in the blacklist assign it a key(profane word), and a value(areplace profane word with asterisk)
          word.gsub!(/\b#{key}\b/, value) # for each word the user has inputed replace the old word(key) with the new word(value)
        end
        word # return the word whether it contains profanity or not
      end

    end
  end
end
