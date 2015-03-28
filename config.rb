require 'csv'
require 'ostruct'
require "json"

helpers do


  def rails

    data.responses.select {|c| c["class"] =~ /Rails/}.sort_by {|lastname| lastname["name"].split(" ").last}

  end

  def js

    data.responses.select {|c| c["class"] =~ /JS/}.sort_by {|lastname| lastname["name"].split(" ").last}

  end


  # adds http protocol when people submit a url without one
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  # Staff csv file
  def staff
    staff = []

    CSV.foreach("./data/staff.csv", headers: true) do |row|
      staff << OpenStruct.new(row.to_hash)
    end
    staff.sort_by {|lastname| lastname["name"].split(" ").last}
  end

  # def campus
  #   campus = []
  #
  #   CSV.foreach("./data/campus.csv", headers: true) do |row|
  #     campus << OpenStruct.new(row.to_hash)
  #   end
  #   campus
  # end

end
# middleman deploy
activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :relative_assets

set :relative_links, true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
