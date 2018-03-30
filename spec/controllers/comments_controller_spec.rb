require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:member) { create(:member) }
  let(:post1) { create(:post) }

  before(:each) do
    authenticate_member(member)
  end

  it 'should create a comment on a post' do
    params = {
      post_id: post1.id,
      comment: {
        content: 'Test comment'
      }
    }
    expect do
      post :create, params: params
    end.to change { Comment.count }.by(1)
  end
end
