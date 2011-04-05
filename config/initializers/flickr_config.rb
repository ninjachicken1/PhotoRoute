# Holds global config for Flickr API
$flickr_config = nil

yml = File.dirname(__FILE__) + '/../flickr.yml'
error = nil
config = {}
begin
  env = RACK_ENV if defined? RACK_ENV
  env = RAILS_ENV if defined? RAILS_ENV
  if ['development'].include?(env)
    puts "***** DEVELOPMENT MODE: expecting config/flickr.yml"
    # Load from config file
    if File.exist?(yml)
      config = YAML::load_file(yml)
    else
      error = "In DEVELOPMENT, Flickr API requires the file 'config/flickr.yml'. See README for instructions."
    end
  else
    puts "***** NON-development MODE: expecting flickr ENV variables."
    # Load from ENV variables (compatible with Heroku)
    config[:key] = ENV['flickr_key']
    config[:secret] = ENV['flickr_secret']
  end

  # Check required keys
  if config[:key].nil? || 
    config[:key].length == 0 || 
    config[:secret].nil? ||
    config[:secret].length == 0

    error = "Flickr API requires the fields 'key' and 'secret'. See README for instructions."
  else
    $flickr_config = config
  end

rescue Exception => ex
  error = "Flickr API could not be initialized. See README for instructions.\nError: #{ex.message}\n#{ex.backtrace}"
end

puts "Flickr API Initialization Error: " + error if error
