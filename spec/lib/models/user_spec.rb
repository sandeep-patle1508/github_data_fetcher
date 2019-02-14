require 'spec_helper'
require './lib/models/user'
require './lib/github_api/client'

describe User do

  describe 'initialize' do
    subject { User.new(params) }
    
    context 'when pass valid params' do
      let(:params) { { id: 1, name: 'test', html_url: 'http://test.com' } }

      it 'set correct attributes' do
        expect(subject.id).to eq(params[:id])
        expect(subject.name).to eq(params[:name])
        expect(subject.html_url).to eq(params[:html_url])
      end

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should be return object of User' do
        expect(subject).to be_an_instance_of(User)
      end
    end

    context 'when pass empty params' do
      let(:params) { { } }

      it 'should raise error' do
        expect { subject }.not_to raise_error
      end

      it 'set nil value for all the attributes' do
        expect(subject.id).to be_nil
        expect(subject.name).to be_nil
        expect(subject.html_url).to be_nil
      end
    end
  end

  describe '#get_public_repos' do

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

    subject { User.get_public_repos(user_name) }

    context 'when valid user name pass' do
      let(:user_name) { 'valid_user' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should return array' do
        expect(subject).to be_an_instance_of(Array)
      end

      it 'should return array of User object' do
        expect(subject.first).to be_an_instance_of(User)
      end

      it 'should return array of two User objects' do
        expect(subject.size).to eql(2)
      end

      it 'should return User object with correct attributes' do
        first_user = subject.first
        expect(first_user.id).to eq(47990984)
        expect(first_user.name).to eq('angular-bootstrap-lightbox')
        expect(first_user.html_url).to eq('https://github.com/sandeep-patle1508/angular-bootstrap-lightbox')
      end
    end

    context 'when invalid user name pass' do
      let(:user_name) { 'invalid_user' }

      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should return array' do
        expect(subject).to be_an_instance_of(Array)
      end

      it 'should return empty array' do
        expect(subject).to be_empty
      end
    end
  end
end