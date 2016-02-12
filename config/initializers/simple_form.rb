SimpleForm.setup do |config|
  defaults = {
    error_class: "field--error",
    readonly: false,
  }

  definition = lambda do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.optional :readonly
    b.optional :placeholder
    b.use :label_input
    b.use :error, wrap_with: { tag: "span", class: "field__error" }
    b.use :hint, wrap_with: { tag: "span", class: "field__hint" }
  end

  config.boolean_style = :nested

  config.wrappers defaults.merge(class: "field"), &definition
  config.wrappers :full, defaults.merge(class: "field field--full"), &definition
  config.wrappers :half, defaults.merge(class: "field field--half"), &definition
  config.wrappers :half_pull, defaults.merge(class: "field field--half field--pull"), &definition
  config.wrappers :third, defaults.merge(class: "field field--third"), &definition
  config.wrappers :third_pull, defaults.merge(class: "field field--third field--pull"), &definition
  config.wrappers :two_third, defaults.merge(class: "field field--twoThird"), &definition
  config.wrappers :two_third_pull, defaults.merge(class: "field field--twoThird field--pull"), &definition
  config.label_text = ->(label, required, _explicit_label) { "#{label} #{required}" }

  config.browser_validations = false
end

module ActionView

  module Helpers

    # :nodoc:
    module FormOptionsHelper

      # This patches Rails's default option group clustering to allow options
      # within a `nil` group to be added directly to the select's root options
      # list. This prevents the formation of ugly unlabeled optgroups.
      #
      # For whatever reason, handling this in a not-ridiculous way was deemed
      # a non-issue by the Rails maintainers:
      # https://github.com/rails/rails/pull/7889
      #
      # rubocop:disable Metrics/ParameterLists
      def option_groups_from_collection_for_select(
        collection,
        group_method,
        group_label_method,
        option_key_method,
        option_value_method,
        selected_key = nil
      )
        collection.map do |group|
          option_tags = options_from_collection_for_select(
            group.send(group_method), option_key_method, option_value_method, selected_key)

          group_label = group.send(group_label_method)
          if group_label.nil?
            option_tags
          else
            content_tag(:optgroup, option_tags, label: group_label)
          end
        end.join.html_safe
      end
      # rubocop:enable Metrics/ParameterLists

    end

  end

end
