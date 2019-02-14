require 'spec_helper'
require './lib/github_data_fetcher/users_controller'

describe GithubDataFetcher::UsersController do

  describe '.show_public_repos' do

    subject { GithubDataFetcher::UsersController.new.show_public_repos(user_name) }

    before(:each) do
      stub_request(:get, 'https://api.github.com/users/valid_user/repos').with(
        headers: {
          'Accept'=>'*/*',
          'User-Agent'=>'Ruby'
        }
      ).to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: File.read('./spec/repos_valid_response.json')
      )

      stub_request(:get, 'https://api.github.com/users/invalid_user/repos').with(
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

    context 'when pass valid user' do
      let(:user_name) { 'valid_user' }
      let(:expected_result) do
        "List of public repositories of valid_user\nangular-bootstrap-lightbox - https://github.com/sandeep-patle1508/angular-bootstrap-lightbox\nreact-bootstrap-lightbox - https://github.com/sandeep-patle1508/react-bootstrap-lightbox\n"
      end
      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should display user public repo details on STDOUT' do
        expect { subject }.to output(expected_result).to_stdout
      end
    end

    context 'when pass valid user' do
      let(:user_name) { 'invalid_user' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should display error message on STDOUT' do
        expect { subject }.to output("Not able to find public repositories for this user\n").to_stdout
      end
    end
  end
end