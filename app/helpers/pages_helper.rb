module PagesHelper
  def sameperson_confirmation
    if user_signed_in? || group_signed_in?
      return true if @account.id == @account_page_info.id &&  @account_type == @account_page_info_type
    end 
  end
end