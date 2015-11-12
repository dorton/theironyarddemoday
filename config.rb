require 'csv'
require 'ostruct'
require "json"
require 'open-uri'


# ["Atlanta", "Charleston", "Greenville", "Las-Vegas", "Nashville", "Orlando", "Washington-DC", "Tampa",
#   "Columbia", "London", "Durham", "Houston", "Austin", "Little-Rock", "San-Antonio", "Dallas", "SLC", "Charlotte", "Indianapolis", "Raleigh"].each do |city|
#   proxy "/#{city.downcase}.html", "/template.html", :locals => { :city_name => city }, :ignore => true
# end

["Houston"].each do |city|
  proxy "/index.html", "/template.html", :locals => { :city_name => city }, :ignore => true
end

helpers do


  def image_name_for_city(city)
    if city == "Tampa"
      "http://theironyard.com/images/locations/tampa/st-petersburg.jpg"
    elsif city == "Nashville"
      "http://theironyard.com/images/locations/nashville/nashville-hero.jpeg"
    elsif city == "London"
      "https://www.ironyard.co.uk/images/locations/london/london-hero.jpg"
    elsif ["Las-Vegas", "Little-Rock", "San-Antonio", "Dallas", "SLC", "Charlotte", "Indianapolis", "Raleigh"].include? city
      "http://theironyard.com/images/locations/#{city.downcase}/#{city.downcase}-hero.jpg"
    else
      "http://theironyard.com/images/locations/#{city.downcase}/#{city.downcase}.jpg"
    end
  end


  def city_demo_date(city)
    all_students.select{|c| c["city"] == city}.map{|s| s["demo_day_date"]}.uniq
  end

  def all_courses(city)
    all_students.select{|c| c["city"] == city}.map{|s| s["course"]}.uniq
  end

  def fetch_students
    json = open("https://tiydemoday.herokuapp.com/api/v1/students").read
    JSON.parse(json)["students"].map do |hash|
      OpenStruct.new(hash)
    end
  end

  def all_students
    @all_students ||= fetch_students
  end

  def current_houston
    all_students.select {|c| c["cohort_id"] == 16}
    # all_students
  end

# filters rails students
    def rails
      current_houston.select {|c| c["course"] =~ /Rails Engineering/}.sort_by {|lastname| lastname["name"].split(" ").last}
    end


# filters js students
    def js
      current_houston.select {|c| c["course"] =~ /Front End Engineering/}.sort_by {|lastname| lastname["name"].split(" ").last}
    end

# filters ui students
    def python
      current_houston.select {|c| c["course"] =~ /Python Data Engineering/}.sort_by {|lastname| lastname["name"].split(" ").last}
    end

# filters mobile students
    def mobile
      current_houston.select {|c| c["course"] =~ /Mobile Engineering/}.sort_by {|lastname| lastname["name"].split(" ").last}
    end


# adds http protocol when people submit a url without one
    def url_with_protocol(url)
      /^http/i.match(url) ? url : "http://#{url}"
    end

    # Staff csv file
    def staff
      data.staff.sort_by {|lastname| lastname.name.split(" ").last}.reverse
    end

    def ta
      data.ta.sort_by {|lastname| lastname.name.split(" ").last}
    end
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
    configure :development do
       activate :livereload
    end

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
