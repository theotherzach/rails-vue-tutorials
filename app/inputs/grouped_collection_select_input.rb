# :nodoc:
class GroupedCollectionSelectInput < SimpleForm::Inputs::GroupedCollectionSelectInput

  def input_html_classes
    super.push("input--select")
  end

end
