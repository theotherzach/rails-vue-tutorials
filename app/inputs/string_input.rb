# :nodoc:
class StringInput < SimpleForm::Inputs::StringInput

  def input_html_classes
    super.push("input--text").push("js--inputText")
  end

end
