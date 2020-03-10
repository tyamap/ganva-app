class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    super(name, label_text, options) if object.new_record?
  end
end
