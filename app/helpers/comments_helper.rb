module CommentsHelper
  def comment_info comment
    user = User.find comment.user_id
    time = time_ago_in_words comment.created_at
    "Made by #{user.first_name} #{user.last_name} #{time} ago"
  end
end
