require 'rails_helper'
require "spec_helper"

RSpec.describe CommentsController, type: :controller do
  describe "comment" do
    it "creates comment" do
      comment = create(:comment)
      expect(comment.body).to eq('Such a great article 1.') # factory comment body 1
    end
  end

  describe "POST #create" do
    it "posts a new comment" do
      expect(Comment.count).to eq(0)
      article = create(:article)
      post :create, params: { comment: attributes_for(:comment),
                              article_id: article.id }
      expect(Comment.count).to eq(1)
    end

    it "allows one article to have multiple comments" do
      expect(Comment.count).to eq(0)
      article = create(:article)
      post :create, params: { comment: attributes_for(:comment),
                              article_id: article.id }
      post :create, params: { comment: attributes_for(:comment),
                              article_id: article.id }
      expect(Comment.count).to eq(2)
    end
  end

  describe "DELETE #destroy" do
    it "deletes comment" do
      article = create(:article_with_comments) # article w/ 3 comments
      expect(Comment.count).to eq(3)
      delete :destroy, params: { article_id: article.id,
                                 id: article.comments.first.id }
      expect(Comment.count).to eq(2)
    end
  end
end
