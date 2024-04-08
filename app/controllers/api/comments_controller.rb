class Api::CommentsController < ApplicationController
  before_action :set_earthquake

  def create
    @comment = @earthquake.comments.build(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_earthquake
    @earthquake = Earthquake.find(params[:earthquake_id])
  end  

  def comment_params
    params.require(:comment).permit(:body).merge(earthquake_id: params[:earthquake_id])
  end
  
end
