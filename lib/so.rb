require 'rest-client'
require 'zlib'

class SO
  module Cli
    def self.parse(argv)
      { user_id:         argv[1],
        endpoint:        argv[2],
        output_filename: argv[3],
      }
    end

    def self.run(argv, stdout)
      options = parse(argv)
      SO.call(options)
      stdout.puts "Successfully wrote the data to #{options[:output_filename]}!"
      0
    end
  end


  def self.call(options)
    response = RestClient.get url_for(options)
    File.write options[:output_filename], response
    response
  end

  def self.url_for(options)
    # endpoint: "users/posts"
    "http://api.stackexchange.com/2.2/users/#{options[:user_id]}/posts?order=desc&sort=activity&site=stackoverflow"
  end
end

class SO
  class HasHashAttributes
    def self.getter_from_attribute(*getter_names)
      getter_names.each do |name|
        define_method(name) { attributes[name] }
      end
    end

    attr_accessor :attributes

    def initialize(attributes)
      self.attributes = attributes
    end
  end

  class User < HasHashAttributes
    getter_from_attribute :reputation,
                          :user_id,
                          :user_type,
                          :accept_rate,
                          :profile_image,
                          :display_name,
                          :link
  end

  class Post < HasHashAttributes
    getter_from_attribute :score,
                          :last_edit_date,
                          :last_activity_date,
                          :creation_date,
                          :post_type,
                          :post_id,
                          :link

    def owner
      @owner ||= User.new(attributes[:owner])
    end
  end
end
