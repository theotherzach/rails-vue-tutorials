# :nodoc:
class CollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput

  def input_html_classes
    super.push("input--select")
  end

end
