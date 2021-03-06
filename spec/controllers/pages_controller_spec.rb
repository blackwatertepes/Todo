require 'spec_helper'

describe PagesController do
	it 'renders the sign in form' do
		get :index
		expect(response.status).to eq 302
	end

	context "signed in" do
		let(:user) { create(:user) }

		before(:each) do
			sign_in :user, user
		end

		it "renders the index" do
			get :index
			expect(response.status).to eq 200	
		end
	end
end
