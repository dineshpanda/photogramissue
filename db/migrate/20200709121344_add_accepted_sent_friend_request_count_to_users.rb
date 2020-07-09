class AddAcceptedSentFriendRequestCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accepted_sent_friend_requests_count, :integer
  end
end
