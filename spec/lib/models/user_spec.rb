require 'spec_helper'
require './lib/models/user'

describe User do
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