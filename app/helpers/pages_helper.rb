module PagesHelper
  def sameperson_confirmation
    if @account.present?
      if @account.id == @account_page_info.id && @account.type == @account_page_info.type
        0
      else
        1
      end
    else
      2
    end
  end

  def move_path_get(id, kind)
    case kind
    when 'Volunteer'
      volunteer_path(id)
    end
  end
end
