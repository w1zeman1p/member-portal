require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:post1) { create(:post) }
  let(:category1) { create(:category) }

  before(:each) do
    authenticate_member(admin)
  end

  it 'should get index' do
    get :index
    expect(response).to have_http_status(200)
  end

  it 'should get new' do
    get :new
    expect(response).to have_http_status(200)
  end

  it 'should create post' do
    params = {
      post: {
        title: 'This is a post',
        content: 'post content',
        category_id: category1.id
      }
    }
    expect do
      post :create, params: params
    end.to change { Post.count }.by(1)
  end

  it 'should show post' do
    get :show, params: { slug: post1.slug }
    expect(response).to have_http_status(200)
  end

  it 'should get edit' do
    get :edit, params: { slug: post1.slug }
    expect(response).to have_http_status(200)
  end

  it 'should update post' do
    patch :update, params: { slug: post1.slug, post: {} }
    expect(response).to redirect_to(post_path(post1))
  end

  it 'should destroy post' do
    post2 = create(:post)
    post1.touch
    before_count = Post.count
    delete :destroy, params: { slug: post1.slug }
    expect(Post.count).to eq(before_count - 1)
    expect(response).to redirect_to(posts_path)
    expect(post2).to be_persisted
  end
end
