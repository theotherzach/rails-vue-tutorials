# ApplicationController is the base controller off of which other controllers
# for this application should build their functionality.
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_default_meta_data

  helper_method :gon

  def raise_not_found!
    raise ActionController::RoutingError, "No route matches #{params[:unmatched_route]}"
  end

  private

  # ----------------------------------------------------------------------------
  # Set default meta data
  #
  # The values set here will be used for the site meta data unless they are
  # overridden in a controller method.
  #
  # Example:
  #
  # def show
  #   @meta_data.merge!({
  #     title: "New Title",
  #     description: "New description here" })
  # end
  #
  # In addition to the defaults below, the following keys can be set:
  #
  #   author: "Content specific author"
  #   fb_app_id: ID number for Facebook app
  #   twit_author: "@authorTwitter"
  # - For app cards:
  #   twit_iphone_id: iOS App Id
  #   twit_iphone_name: iOS App Name
  #   twit_iphone_url: iOS App URL
  #   twit_google_id: Google App Id
  #   twit_google_name: Google App Name
  #   twit_google_url: Google App URL
  # - For video cards:
  #   twit_keyframe: Image path for Video Keyframe
  #   twit_player: URL for video player
  #   twit_video_width: Width of player
  #   twit_video_height: Height of player
  # ----------------------------------------------------------------------------

  def set_default_meta_data
    @meta_data = {
      title: text("meta_data.title", scope: "controllers.application"),
      description: text("meta_data.description", scope: "controllers.application"),
      google_site_verification: Rails.application.secrets.google_site_verification_id,
      og_title: text("meta_data.og.title", scope: "controllers.application"),
      og_description: text("meta_data.og.description", scope: "controllers.application"),
      og_type: text("meta_data.og.type", scope: "controllers.application"),
      og_image: "cards/twit.png",
      og_sitename: text("meta_data.og.sitename", scope: "controllers.application"),
      fb_app_id: text("meta_data.app_id.fb", scope: "controllers.application"),
      twit_title: text("meta_data.twit.title", scope: "controllers.application"),
      twit_account: text("meta_data.twit.account", scope: "controllers.application"),
      twit_description: text("meta_data.twit.description", scope: "controllers.application"),
      twit_card: text("meta_data.twit.card", scope: "controllers.application"),
      twit_image: "cards/twit.png",
      apple_app_id: text("meta_data.app_id.apple", scope: "controllers.application") }
  end

end
