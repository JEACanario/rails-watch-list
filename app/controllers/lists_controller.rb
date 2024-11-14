class ListsController < ApplicationController
  before_action :find_list, only: %i[show]

  def index
    @lists = List.all
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list), notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @list = List.new
  end

  def show

  end

  private

  def list_params
    params.require(:list).permit(:name, :image_url)
  end

  def find_list
    @list = List.find(params[:id])
  end
end
