module PagesHelper
  def sameperson_confirmation
    return true if @account.id == @account_page_info.id &&  @account_type == @account_page_info_type 
  end
end
