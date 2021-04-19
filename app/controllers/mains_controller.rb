class MainsController < ApplicationController
  def index
    @volunteer = Volunteer.order('created_at DESC').limit(10)
    $volunteer_post_number = @volunteer.count
    $image_path = File.expand_path('app/assets/images/noimage.png', Rails.root)
  end

  # 新規登録・ログインの選択画面
  def sign_up_choice
  end

  def sign_in_choice
  end
end
