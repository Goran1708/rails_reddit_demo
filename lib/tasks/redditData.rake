require 'open-uri'

task :subreddits => :environment do
  response = open('https://www.reddit.com/reddits.json?sort=hot%27').read
  obj = JSON.parse(response)

  obj['data']['children'].first(10).each_with_index do |job, index|
    Subreddit.find_or_create_by name: job['data']['display_name'], 
                                title: job['data']['title'],
                                description: job['data']['public_description']
                      
    fill_posts(Subreddit.find index+1)
  end
end

def fill_posts(subreddit)
  
  response = open("https://www.reddit.com/r/#{subreddit.name}/new.json?sort=new").read
  obj = JSON.parse(response)
  
  obj['data']['children'].first(10).each_with_index do |job, index|
    if job['data']['selftext'].nil? || job['data']['selftext'].empty?
      Post.find_or_create_by title: job['data']['title'], 
                             creator_name: job['data']['author'],
                             content: job['data']['url'],
                             subreddit_id: subreddit.id
    else
       Post.find_or_create_by title: job['data']['title'], 
                              creator_name: job['data']['author'],
                              content: job['data']['selftext'],
                              subreddit_id: subreddit.id
    end
    #fill_comments(Post.find(index+1), job['data']['permalink'])
  end
end

=begin
def fill_comments(post, permalink)

  response = open("http://www.reddit.com#{permalink}.json").read
  obj = JSON.parse(response)
  
  obj.each do |job1|
    job1['data']['children'].each do |job2|
      Comment.find_or_create_by content: job2['data']['body'], 
                                author_name: job2['data']['author'],
                                post_id: post.id.to_i
    end
  end
end
=end