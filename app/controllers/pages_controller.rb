# PagesController is a generic controller for rendering static pages.
class PagesController < ApplicationController

  def home
  end

  def filter_list
    @q = filter_list_params[:q]
    @people = Person.all_or_search(filter_list_params[:q])
  end

  private

  def filter_list_params
    params.permit(:q)
  end

end
