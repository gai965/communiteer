module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account

    def connect
      self.current_account = find_verified_account
    end

    private

    def find_verified_account
      if env['warden'].authenticated?(:user)
        verified_account = User.find_by(id: cookies.encrypted[:user_id])
      elsif env['warden'].authenticated?(:group)
        verified_account = Group.find_by(id: cookies.encrypted[:group_id])
      end
      verified_account
    end
  end
end
