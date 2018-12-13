require "rails_helper"
require "spec_helper"

RSpec.describe ArticlesController, :type => :controller do

  describe "article" do
    it "creates article" do
      article = create(:article)

      expect(article.title).to eq('My Article')
    end
  end

  describe "GET #index" do
    it "has a 200 status" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "renders the show view" do
      article = create(:article)
      get :show, params: { id: article.id }
      expect(response).to render_template("show")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new article" do
        post :create, params: { article: attributes_for(:article) }
        expect(Article.count).to eq(1)
      end

      it "redirects to the new article" do
        post :create, params: { article: attributes_for(:article) }
        expect(response).to redirect_to Article.last
      end
    end

    context "with invalid attributes" do
      it "does not create new article" do
        post :create, params: { article: attributes_for(:invalid_article) }
        expect(Article.count).to eq(0)
      end

      it "re-renders the #new method" do
        post :create, params: { article: attributes_for(:invalid_article) }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "valid attributes" do
      let(:attr) do
        { :title => "My New Title", :text => "My new article text." }
      end
      let(:article) { create(:article) }

      before(:each) do
        put :update, params: { id: article.id, article: attr }
        article.reload
      end

      it { expect(response).to redirect_to(article) }
      it { expect(article.title).to eq('My New Title') }
      it { expect(article.text).to eq('My new article text.') }
    end

    context "invalid attributes" do
      let(:invalid_attr) do
        { :title => nil, :text => nil }
      end
      let(:article) { create(:article) }
      
      before(:each) do
        put :update, params: { id: article.id, article: invalid_attr }
        article.reload
      end

      it { expect(response).to render_template("edit") } # re-renders edit w/ invalid
      it { expect(article.title).to eq('My Article') } # factory article title
      it { expect(article.text).to eq('This is my article text.') } # factory text
    end
  end

  describe "DELETE #destroy" do
    it "deletes article" do
      article = create(:article)
      expect(Article.count).to eq(1)
      delete :destroy, params: { id: article.id }
      expect(Article.count).to eq(0)
    end
  end
end
