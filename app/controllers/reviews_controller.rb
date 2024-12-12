class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)

    if @review.save
      ActionCable.server.broadcast("book_#{@book.id}_reviews", {review: render_review(@review)})
      redirect_to book_path(@book.id)
    else
      render json: { error: "Unable to save review" }, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def render_review(review)
    ApplicationController.renderer.render(partial: 'reviews/review', locals: { review: review })
  end
end
