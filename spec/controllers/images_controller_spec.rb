require 'spec_helper'

describe ImagesController do
  before :each do
    user = create(:user)
    session[:remember_token] = user.remember_token

    @page = create(:page, user: user)
  end

  describe "POST#create" do
    it "saves the valid image" do
      expect{
        post :create, format: :js,
             image: attributes_for(:image), page_id: @page.slug
      }.to change(Image, :count).by(1)
    end
  end

  describe "DELETE#destroy" do
    it "deletes the image" do
      image = create(:image, blog_record: @page)

      expect{
        delete :destroy, format: :js,
               page_id: @page.slug, id: image.id
      }.to change(Image, :count).by(-1)
    end
  end
end
