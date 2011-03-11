# Holds global config for Flickr API
$flickr_config = nil

yml = File.dirname(__FILE__) + '/../flickr.yml'
error = nil
begin
  if File.exist?(yml)
    config = YAML::load_file(yml)

    # Check required keys
    if config[:key].nil? || 
      config[:key].length == 0 || 
      config[:secret].nil? ||
      config[:secret].length == 0

      error = "Flickr API requires the fields 'key' and 'secret'. See README for instructions."
    else
      $flickr_config = config
    end
    
  else
    error = "Flickr API requires the file 'config/flickr.yml'. See README for instructions."
  end
rescue Exception => ex
  error = "Flickr API could not be initialized from 'config/flickr.yml'. See README for instructions.\nError: #{ex.message}\n#{ex.backtrace}"
end

puts "Flickr API Initialization Error: " + error if error
