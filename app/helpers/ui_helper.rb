# UiHelper represents a set of useful generic behaviors for building out
# interface components.
module UiHelper

  # Public: Defer the loading of a JS asset until after the document
  # load event has been fired
  #
  # file - filename (with path if nested in the javascripts folder)
  #
  # Example: = defer_javascript_include_tag('defer')
  # Example: = defer_javascript_include_tag('defer.js')
  # Example: = defer_javascript_include_tag('folder/nested-defer.js')
  #
  # Returns a partial that renders a :coffee filter.
  def defer_javascript_include_tag(file)
    file << ".js" unless file.to_s.end_with?(".js")
    render "shared/defer_js", file: file
  end

  # Public: Render svg markup to pull proper icon from svg sprite
  #
  # icon - icon path id for icon in javascripts/svg-icons.js.coffee
  # class (optional) - additional classes to add to icon
  #
  # Example: = svg_icon('twitter')
  # Example: = svg_icon('facebook', class: 'icon--large')
  #
  # Returns an <svg> tag with a nested <use> tag.
  def svg_icon(icon, options = {})
    content_tag :svg, class: "icon icon--#{icon} #{options[:class]}", viewBox: "0 0 100 100" do
      content_tag :use, "xlink:href": "##{icon}" do
      end
    end
  end

  # Public: Get a string representation of the year range, given a start year.
  #
  # start_year - The year from which to calculate the range
  #
  # Examples:
  #
  #   copyright_year_range(2013)
  #   # => "2013"
  #
  #   copyright_year_range(2012)
  #   # => "2012 - 2013"
  #
  # Returns a String.
  def copyright_year_range(start_year)
    current_year = Time.current.year
    if current_year > start_year
      "#{start_year} - #{current_year}"
    else
      "#{start_year}"
    end
  end

  # Public: Get the site name.
  #
  # Useful for places where the site name needs to be included, like page
  # titles or meta tags.
  #
  # Returns a String.
  def site_name
    t("site_name")
  end

  # Public: Get a full image URL.
  #
  # Useful for places where an image needs a full path, like meta tags.
  #
  # Example: image_url('cards/fb.png')
  #
  # Returns a String.
  def image_url(source)
    URI.join(root_url, image_path(source))
  end

end
