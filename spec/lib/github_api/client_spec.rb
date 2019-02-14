require 'spec_helper'
require './lib/github_api/client'
require 'json'

describe GithubApi::Client do

  describe '.get_public_repos' do

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

    subject { GithubApi::Client.new.get_public_repos(user_name) }

    context 'when pass valid user name' do
      let(:user_name) { 'valid_user' }

      it 'should return array data' do
        expect(subject.parsed_response).to be_an_instance_of(Array)
      end

      it 'should return success response' do
        expect(subject.success?).to be_truthy
      end

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'when pass invalid user name' do
      let(:user_name) { 'invalid_user' }

      it 'should return error hash' do
        expect(subject.parsed_response).to be_an_instance_of(Hash)
      end

      it 'should return not found error status' do
        expect(subject.not_found?).to be_truthy
      end

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end
    end
  end
end