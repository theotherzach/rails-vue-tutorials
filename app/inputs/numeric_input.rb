# :nodoc:
class NumericInput < SimpleForm::Inputs::NumericInput

  def input_html_classes
    super.push("input--text").push("js--inputText")
  end

end
