class CommentsController < ApplicationController
	def create
		find_post
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	def destroy
		find_post
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	def edit
		find_post
		@comment = @post.comments.find(params[:id])
	end

	def update
		find_post
		@comment = @post.comments.find(params[:id])
		if @comment.update(params[:comment].permit(:comment))
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	def upvote
		find_post_and_comment
		@comment.upvote_by current_user
		redirect_to :back
	end

	def downvote
		find_post_and_comment
		@comment.downvote_by current_user
		redirect_to :back
	end

	private

	def find_post_and_comment
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
	end
end
