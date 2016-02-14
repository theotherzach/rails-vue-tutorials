# PagesController is a generic controller for rendering static pages.
class PagesController < ApplicationController

  def home
  end

  def filter_list
    @people = Person.all
  end

end
