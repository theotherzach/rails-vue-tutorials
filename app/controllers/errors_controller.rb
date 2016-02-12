# ErrorsController is responsible for handling the display of error pages within
# the application.
class ErrorsController < ApplicationController

  def not_found
    render_error_page(404)
  end

  def not_permitted
    render_error_page(422)
  end

  def server_error
    render status: 500, layout: false
  end

  private

  def render_error_page(status_code)
    render(
      :not_found,
      status: status_code,
      layout: "application",
      formats: [:html],
    )
  end

end
