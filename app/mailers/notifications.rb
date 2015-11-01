class Notifications < ApplicationMailer
  
  def comments(user, comment)
     @comment = comment
     mail(to: user.email, subject: "#{comment.post.title} - New comment")
  end
end
