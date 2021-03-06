class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :text_field, :date_field, :date_select, :password_field,
           :time_select, :collection_select, :number_field,
           :check_box, :radio_button, :text_area, :select, :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def notes
    markup(:div, class: 'notes') do |m|
      m.span '*', class: 'mark'
      m.text '印の付いた項目は入力必須です'
    end
  end

  def text_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      m << error_messages_for(name)
    end
  end

  def textarea_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << text_area(name, options)
      m << error_messages_for(name)
    end
  end

  def email_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      m << error_messages_for(name)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << password_field(name, options)
      m << error_messages_for(name)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << date_field(name, options)
      m << error_messages_for(name)
    end
  end

  def date_select_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << date_select(name, options)
      m << error_messages_for(name)
    end
  end

  def number_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << number_field(name, options)
      m << error_messages_for(name)
    end
  end

  def time_select_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << time_select(name, options)
      m << error_messages_for(name)
    end
  end

  def drop_down_list_block(name, label_text, choices, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << select(name, choices, { include_blank: true }, options)
      m << error_messages_for(name)
    end
  end

  def drop_down_collection_block(attr_name, label_text, collection, value, view, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(attr_name, label_text, options)
      m << collection_select(attr_name, collection, value, view, options)
      m << error_messages_for(attr_name)
    end
  end

  def error_messages_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: 'error-message') do |mm|
          mm.text message
        end
      end
    end
  end

  def decorated_label(name, label_text, options = {})
    label(name, label_text, class: options[:required] ? 'required' : nil)
  end
end
