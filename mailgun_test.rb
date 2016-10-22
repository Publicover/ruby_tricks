XXXXX 1. new rails app
  rails new app_name

XXXXX 2. put up on heroku

  A. MAKE SURE YOU ARE ON MASTER BRANCH
     git checkout master
  B. MAKE SURE POSTGRES IS INSTALLED
  C. GET GEMFILE READY
    1. ruby '2.3.0'
    2. gem 'pg'
       gem 'rails_12factor', group: :production
    3. create Procfile
       web: bundle exec puma -C config/puma.rb
  D. RUN COMMANDS
    bundle install
    git add .
    git commit -m "message and shit"
    git push heroku master
    heroku local 

3. rails app with users
  a. devise gem

4. export csv

5. import csv

6. hook up mailgun

7. take what you can from reserve_yacht on heroku
  a. look at commit history

8. add secret info to ~/.bash_profile

9. implement css
