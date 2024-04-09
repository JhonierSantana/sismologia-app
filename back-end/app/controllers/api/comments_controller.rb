class Api::CommentsController < ApplicationController
  def create
    @earthquake = Earthquake.find_by(id: params[:feature_id])
    unless @earthquake
      render json: { error: "Earthquake with ID #{params[:feature_id]} not found" }, status: :not_found
      return
    end

    @comment = @earthquake.comments.build(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:body)
  end
end
