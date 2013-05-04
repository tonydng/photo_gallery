<h1>Install</h1>
<p>$ git clone git@github.com:tonydng/photo_gallery.git</p>
<p>$ cd tasks</p>
<p>$ bundle</p>
<p>$ rake db:migrate</p>

<h3><a href="https://devcenter.heroku.com/articles/s3#s3-setup">S3 setup</a> must be done first.</h3>

<h3>Initial Setup CarrierWave File Upload</h3>
<p>Add the following lines to config/initializers/carrierwave.rb</p>
<pre>
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.fog_directory = ENV['AWS_S3_BUCKET']
end
</pre>

<h3>Setup AWS to run your application locally</h3>
<p>$ sudo gedit ~/.bashrc</p>
<p>Enter these lines at the bottom of .bashrc file</p>
<p>export AWS_ACCESS_KEY_ID=your_access_key_id</p>
<p>export AWS_SECRET_ACCESS_KEY=your_secret_access_key</p>
<p>export AWS_S3_BUCKET=your_bucket_name</p>

<p>$ rails s</p>

<p>From the web browser access the site locally via http://localhost:3000</p>

<h1>Deploy the application to Heroku</h1>
<p>$ heroku create your_app_name
<p>$ git push heroku master
<p>$ heroku run rake db:migrate 

<h3>Setup the AWS S3 config vars on Heroku:</h3>
<p>$ heroku config:add AWS_S3_BUCKET=your_bucket_name</p>
<p>$ heroku config:add AWS_ACCESS_KEY_ID=your_access_key_id</p>
<p>$ heroku config:add AWS_SECRET_ACCESS_KEY=your_secret_access_key</p>

<hr>
<p>&copy; created in 2013 by <a href="http://tonydng.com" target="_blank">Tony Nguyen</a></p>