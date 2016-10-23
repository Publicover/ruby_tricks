XXXXX 1. new rails app
  A. create
    rails new app_name
  B. generate dashboard
    rails generate controller dashboards index
  C. set root route in config
    root 'dashboards#index'
  C. generate model
    rails generate model Thingname name:string age:integer
    rake db:migrate
    heroku rake db:migrate
  D. generate controller
    rails generate controller thingnames index show new edit create update destroy
  E. set resources (in plural) in config
    resources :thingnames
  F. set up controller
    see example
  G. set up form
    create _form.html.erb in proper views folder
    see example
    skull tags render 'form' in index edit
  H. set up index page
    see example
  I. set up show page
    see example
  J. set links at bottom of dashboards/index, index, show, edit
    <%= link_to "HOME INDEX", thingnames_path %> <br>
    on dashboard/index, put link to index, new
    on show, put link to index, edit, new and dashboard
    on edit, put link to index, new, show and dashboard
    on new, put link to index and dashboard

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

XXXXX 3. add devise gem
  A. gem 'devise' in gemfile
  B. rails g devise:install
  C. define default URLs--in config/environments/development.rbj before end keyword
      config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  D. in app/views/layouts/application.html.erb, before yield statment
    # <% if notice %>
    #   <p class="alert alert-success"><%= notice %></p>
    # <% end %>
    # <% if alert %>
    #   <p class="alert alert-danger"><%= alert %></p>
    # <% end %>
  E. create a User model
    rails g devise user
    rake db:migrate
    heroku rake db:migrate
  F. RESTART SERVER
  G. again in application.html.erb
    # <p class="navbar-text pull-right">
    #   <% if user_signed_in? %>
    #     Logged in as <strong><%= current_user.email %></strong>.
    #     <%= link_to 'Edit profile', edit_user_registration_path, :class => 'navbar-link' %> |
    #     <%= link_to "Logout", destroy_user_session_path, method: :delete, :class => 'navbar-link'  %>
    #   <% else %>
    #     <%= link_to "Sign up", new_user_registration_path, :class => 'navbar-link'  %> |
    #     <%= link_to "Login", new_user_session_path, :class => 'navbar-link'  %>
    #   <% end %>
  H. in application_controller.rb, after protect_from_forgery with: :exception
    before_action :authenticate_user!

XXXXX 4. export csv
  A. in config/application, after require 'rails/all'
    require 'csv'
  B. put the following in controller in index
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @reservations.to_csv }
    # end
  C. in the model, put this method
    # def self.to_csv
    #   CSV.generate do |csv|
    #     csv << column_names
    #     all.each do |result|
    #       csv << result.attributes.values_at(*column_names)
    #     end
    #   end
    # end

5. import csv

6. hook up mailgun

7. take what you can from reserve_yacht on heroku
  a. look at commit history

8. add secret info to ~/.bash_profile

9. implement css grid
