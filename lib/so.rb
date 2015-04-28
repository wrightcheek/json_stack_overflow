require 'rest-client'
require 'zlib'

module SO
  module Cli
    def self.parse(argv)
      { user_id:         argv[1],
        endpoint:        argv[2],
        output_filename: argv[3],
      }
    end

    # argv:  ["-u", "184212", "users/posts", "test_posts.json"]
    def self.run(argv, stdout)
      options = parse(argv)

      # query the api
      response = RestClient.get "http://api.stackexchange.com/2.2/users/#{options[:user_id]}/posts?order=desc&sort=activity&site=stackoverflow"

      # write to the file
      File.write options[:output_filename], response

      stdout.puts "Successfully wrote the data to #{options[:output_filename]}!"

      0
    end
  end
end
