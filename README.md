# TWILIO VERIFY AND WEATHER FORECAST

** About

- This application demonstrates how to do simple phone verification with Ruby on Rails Framework, and Twilio Verify.
- check the weather forecast update according to city wise

** SetUp

- Make sure Ruby is installed. Ruby version 3.3.0 is recommended.
- Make sure you have a Ruby version manager, like e.g. rbenv. Alternatively, pick RVM.
- Make sure you have Bundler installed. If not, run $ gem install bundler.
- Run $ bundle install to install all dependencies, including Rails 7.1.3. Note: Rails runs in API mode, so there are no views.
- Copy .env file, cp .env.example .env
- Run $ rails db:create db:migrate to create the database, run all migrations.
- To start Rails, run $ rails s.

** Third party api's

- Twilio Account settings
  Required all config value to run the application
   - TWILIO_ACCOUNT_SID / TWILIO_AUTH_TOKEN:  For twilio API credentials find here https://www.twilio.com/console
   - TWILIO_VERIFICATION_SID:	For Verification Service SID find here https://www.twilio.com/console/verify/services
- Weather integration settings
  Required config to run the application
  	- WEATHER_FORCAST: For weather forecast API credentials find here https://www.weatherapi.com/my
 

