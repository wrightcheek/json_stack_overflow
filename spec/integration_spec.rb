require 'open3'
require 'json'

RSpec.describe 'so' do
  let(:path_to_executable) { File.expand_path '../bin/so', __dir__ }
  let(:joshs_userid)       { '184212' }
  let(:output_filename)    { 'test_posts.json' }

  after { File.delete output_filename if File.exist? output_filename }

  it 'queries the data from stack overflow' do
    # call the program ($ so -u 184212 users/posts test_posts.json)
    stdout, stderr, status = Open3.capture3 path_to_executable,
                                            '-u', joshs_userid,
                                            'users/posts',
                                            output_filename

    # exited successfully
    expect(stderr).to be_empty
    expect(status).to be_success
    expect(stdout).to include output_filename

    # check the data is where I expect it to be
    json = JSON.parse(File.read(output_filename))

    # check the data has keys
    expect(json.keys.sort).to eq ["has_more", "items", "quota_max", "quota_remaining"]
  end
end
