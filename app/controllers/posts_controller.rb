# frozen_string_literal: true

# Post controller
class PostsController < ApplicationController
  before_action :find_post, only: %i[show edit update destroy]
  def index
    if params[:category].blank?
      @posts = Post.all.order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(category_id: @category_id).order('created_at DESC')
    end
  end

  def show() end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit() end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Update successful.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html do
        redirect_to posts_url,
                    notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.fetch(:post, {}).permit(
      :title, :content, :category_id
    )
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
