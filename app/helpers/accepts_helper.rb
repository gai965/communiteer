module AcceptsHelper
  def approver_verification
    return true if @account.id == @volunteer.postable_id && @account.type == @volunteer.postable_type
  end

  def accept_get_path(post_id, participant)
    case params[:controller]
    when 'join_volunteers'
      volunteer_accepts_path(post_id, id: participant[:id], type: participant[:type])
    end
  end
end
