# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

# Was trying to solve this issue in Chrome:
#   "Resource interpreted as font but transferred with MIME type application/x-woff""
# Not sure if correct: http://www.jbarker.com/blog/2009/mime-type-css-web-fonts
fonts = {
  '.eot' => 'application/vnd.ms-fontobject',
  '.ttf' => 'font/ttf',
  '.otf' => 'font/otf',
  '.woff' => 'application/x-woff'
}
Rack::Mime::MIME_TYPES.merge!(fonts)

