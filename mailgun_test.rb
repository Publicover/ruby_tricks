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
    heroku create appnamenospaces
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

XXXXX 5. import csv
  0. require 'csv' if not already required
  A. create new file called import.rake in lib/tasks, write
    # namespace :import do
    #
    #   task :reservations => :environment do
    #     csv_text = File.read("lib/reservations_test.csv")
    #     csv = CSV.parse(csv_text, :headers => true)
    #     csv.each do |row|
    #       Reservation.create!(row.to_hash)
    #     end
    #   end
    # end
  B. put your csv file loose in the lib file, call it whatever.csv
  C. call the rake with
    rake import:table_name_plural

6. hook up mailgun
  A. create methods in relevant controller (write_email or similar name)
    # ReportMailer.view_single(params[:address]).deliver_now
  B. generate mailer with actions named after function of emails
    # rails g mailer UserMailer view_single
  C. change routes
    # get 'report/write_email'
    # post 'report/send_email'
  D. create views named after mailer actions
    # write_email.html.erb
    # send_email.html.erb
  E. in write_email, use the following:
    # <h1>Write an email</h1>
    #
    # <%= form_tag reports_send_email_path do %>
    #   <%= email_field_tag :address, nil, placeholder: "Email address" %>
    #   <%= submit_tag "SEND ME AN EMAIL"%>
    # <% end %>
  F. in send_email, use something like below:
    # <h1>Reports#send_email</h1>
    # <p>Find me in app/views/reports/send_email.html.erb</p>
    # <br><h1><p>You sent an email to <%= params[:address] %>. </p></h1>

  in config/$RAILS_ENV.rb, change config.action_mailer.raise_delivery_errors to true
  paste the following under that
    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    # address:              'smtp.gmail.com',
    # port:                 587,
    # domain:               'example.com',
    # user_name:            '<username>',
    # password:             '<password>',
    # authentication:       'plain',
    # enable_starttls_auto: true  }
  when done sending emails in development, change .raise_delivery_errors back to false
  in config, fill matching info from the Mailgun Domain page
  put mailgun information in ~/.bash_profile

  put the following in the config/production
    # config.action_mailer.raise_delivery_errors = true
    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   :port           => ENV['MAILGUN_SMTP_PORT'],
    #   :address        => ENV['MAILGUN_SMTP_SERVER'],
    #   :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    #   :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    #   :domain         => 'fulltestsuite.herokuapp.com', #eg: 'yourappname.herokuapp.com'
    #   :authentication => :plain,
    # }
    integrate PointDNS
    add the TXT files from https://mailgun.com/app/domains/fulltestsuite.herokuapp.com/verify

    add attachments:
      in mailer, add before mail to:
        # attachments['publicover_resume.pdf'] = File.read('public/JimPublicoverDevNC2016.pdf')


XXXXX 7. take what you can from reserve_yacht on heroku
  a. look at commit history
    DONE

XXXXX 8. add secret info to ~/.bash_profile
  in Terminal, use
    atom .bash_profile

9. implement css grid

10. sortable columns

11. click to open in new tab

XXXXX 12. make it responsive and mobile-first
  A. in app/view/layouts/application, put the following:
    # <meta name="viewport" content="width=device-width, initial-scale=1.0">

13. embed something from the Google API

14. ajax implementation

15. do really anything with javascript
