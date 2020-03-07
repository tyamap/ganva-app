module ApplicationHelper
  include HtmlBuilder

  # タイトル表示を作成
  def document_title
    if @title.present?
      "#{@title} - Ganva!"
    else
      'Ganva!'
    end
  end
end
