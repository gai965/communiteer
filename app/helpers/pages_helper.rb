module PagesHelper
  def sameperson_confirmation
    if @account.present?
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
