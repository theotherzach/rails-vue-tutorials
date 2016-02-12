# :nodoc:
class PasswordInput < SimpleForm::Inputs::PasswordInput

  def input_html_classes
    super.push("input--text").push("js--inputText")
  end

end
