module PagesHelper
  def sameperson_confirmation
    if user_signed_in? || group_signed_in?
      if @account.id == @account_page_info.id && @account_type == @account_page_info_type
        return 0 
      else
        return 1 
      end
    else
      return 2
    end 
  end
end