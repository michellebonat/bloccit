class FavoriteMailer < ActionMailer::Base
  default from: "michelle.bonat@gmail.com"

     def new_comment(user, post, comment)
 
     # New Headers
     headers["Message-ID"] = "<comments/#{comment.id}@mbonat-bloccit.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@mbonat-bloccit.example>"
     headers["References"] = "<post/#{post.id}@mbonat-bloccit.example>"
 
     @user = user
     @post = post
     @comment = comment
 
     mail(to: user.email, subject: "New comment on #{post.title}")
   end
end
