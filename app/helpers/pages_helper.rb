module PagesHelper
  def sameperson_confirmation
    if user_signed_in? || group_signed_in?
      if @account.id == @account_page_info.id &&  @account.type == @account_page_info_type
        0
      else
        1
      end
    else
      2
    end
  end
end
