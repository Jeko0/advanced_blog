set :output, './log/cron.log'

every 2.days do 
  runner "Post.inactive_post"
end