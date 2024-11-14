class BookmarksController < ApplicationController
  before_action :find_list

  def index
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
  
    if @bookmark.save
      redirect_to list_path(@list), notice: "bookmark was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @bookmark = Bookmark.new
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
