require 'spec_helper'

describe GalleriesController do 
  it "displays an error for a missing gallery" do 
    get :show, id: "not-here"
    expect(response).to redirect_to(galleries_path)
    message = "The gallery you were looking for could not be found."
    expect(flash[:error]).to eql(message)
  end
end