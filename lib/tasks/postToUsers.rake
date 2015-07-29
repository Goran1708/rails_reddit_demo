task :createUser => :environment do

  Post.find_each do |job|
    #puts job.creator_name + '@tidder.com'
    #puts 'valid_password'
    #puts job.creator_name
    
    User.create email: job.creator_name + '@tidder.com', 
                           password: 'valid_password',
                           password_confirmation: 'valid_password',
                           nickname: job.creator_name
    
  end
end

task :postToUser => :environment do
  
  User.find_each do |job|
    #puts Post.where(creator_name: job.nickname)
    Post.where(creator_name: job.nickname).update_all(user_id: job.id)
  end
end

task :commentToUser => :environment do
  
  User.find_each do |job|
    puts Post.where(creator_name: job.nickname)
    Comment.where(author_name: job.nickname).update_all(user_id: job.id)
  end
end