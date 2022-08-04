class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    # raise
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      # render 'new', status: :unprocessable_entity => orig code with 'new' action for bookmark
      render 'lists/show', status: :unprocessable_entity
    end
    # raise
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # raise
    redirect_to list_path(@bookmark.list), status: :see_other
    # redirect_to root_path, status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
