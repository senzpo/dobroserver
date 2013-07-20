require 'spec_helper'

describe PagesController do
 #render_views

 describe "guest access" do
    before :each do
      user = create(:user)
      @page = create(:page, user: user)
    end

    # describe "GET#index" do
    #   it "renders the :index view" do
    #     get :index
    #     expect(response).to render_template :index
    #   end
    # end

    # describe "GET#feed" do
    #   it "renders the :feed view" do
    #     get :feed, format: :atom
    #     expect(response).to render_template :feed
    #   end
    # end

    describe "GET#show" do
      it "renders the :show view for published page" do
        get :show, id: @page.slug
        expect(response).to render_template :show
      end

      it "denies access for non published page" do
        page = create :page, published: false
        get :show, id: page.slug

        expect(response).to redirect_to root_url
      end
    end
  end

  describe "admin access" do
    before :each do
      @user = create(:user, admin: true)
      session[:remember_token] = @user.remember_token

      @page = create(:page, user: @user)
    end

    describe "GET#show" do
      it "grants access for non published page" do
        page = create :page, published: false
        get :show, id: page.slug

        expect(response).to render_template :show
      end
    end

    describe "GET#edit" do
      it "renders the :edit view" do
        get :edit, id: @page.slug

        expect(response).to render_template :edit
      end
    end

    describe "GET#new" do
      it "renders the :edit view" do
        get :new, id: @page.slug

        expect(response).to render_template :new
      end
    end

    describe "page#create" do
      it "saves the valid page to database" do
        expect{
          post :create, page: attributes_for(:page)
        }.to change(Page, :count).by(1)
      end

      context "with invalid attributes" do
        it "re-renders new template" do
          post :create, page: attributes_for(:page, content: "")

          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH#update" do
      it "updates the valid page" do
        patch :update, id: @page.slug,
          page: attributes_for(:page, content: "chunky bacon")

        expect(@page.reload.content).to eq "chunky bacon"
      end

      context "with invalid attributes" do
        it "re-renders edit template" do
          patch :update, id: @page.slug,
            page: attributes_for(:page, content: "")

          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE#destroy" do
      it "deletes the page" do
        expect{
          delete :destroy, id: @page.slug
        }.to change(Page, :count).by(-1)
      end
    end
  end
end
