require 'spec_helper'
require './lib/github_data_fetcher'

describe GithubDataFetcher::App do

  describe '.run' do
    # mock the github repos api response
    before(:each) do
      stub_request(:get, "https://api.github.com/users/valid_user/repos").with(
        headers: {
          'Accept'=>'*/*',
          'User-Agent'=>'Ruby'
        }
      ).to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: File.read('./spec/repos_valid_response.json')
      )

      stub_request(:get, "https://api.github.com/users/invalid_user/repos").with(
        headers: {
          'Accept'=>'*/*',
          'User-Agent'=>'Ruby'
        }
      ).to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 404,
        body: '{"message": "Not Found", "documentation_url": "https://developer.github.com/v3"}'
      )
    end

    subject { GithubDataFetcher::App.new.run(argv) }

    context 'when pass valid user_name argv' do
      let(:argv) { ['valid_user'] }

      it 'should not raise error' do
         expect { subject }.not_to raise_error
      end

      it "should run and initiated GithubDataFetcher" do
        expect( subject ).to_not be false
      end
    end

    context 'when pass invalid user_name argv' do
      let(:argv) { [] }

      it 'should raise error' do
         expect { subject }.to raise_error('please enter user name')
      end
    end
  end
end