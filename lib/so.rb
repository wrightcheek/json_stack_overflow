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
