# :nodoc:
class CollectionCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput

  def input_html_classes
    super.push("input--boolean")
  end

  def label_html_options
    options = super

    options[:class] ||= []
    options[:class]
      .push("label--boolean")
      .push("label--checkbox")
      .push("js--inputBoolean")

    options
  end

end
