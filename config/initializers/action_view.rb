# form_with　で毎回　remote: false を設定しなくて済むように設定
Rails.application.configure do
  config.action_view.form_with_generates_remote_forms = false
end