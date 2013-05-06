require 'spec_helper'

describe Admin::UsersController do
	let(:user) { Factory(:confirmed_user) }

  context "standard users" do 
  	before { sign_in(:user, user) }

  	it "is not be able to access the index action" do 
  		get 'index'
  		expect(response).to redirect_to root_path
  		expect(flash[:error]).to eql("You must be an admin to do that.")
  	end
  end

end
