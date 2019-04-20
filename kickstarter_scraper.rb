require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text.strip
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.sub("%", "").to_i

def title
  project.css("h2.bbcard_name strong a").text
end

def image_link
  project.css("div.project-thumbnail a img").attribute("src").value
end

def description
  project.css("p.bbcard_blurb").text.strip
end

def location
  project.css("ul.project-meta span.location-name").text
end

def percent_funded
  project.css("ul.project-stats li.first.funded strong").text.sub("%", "").to_i
end

def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = kickstarter.css("li.project.grid_4")

  project_hash = {}
  projects.each do |project|
    project_hash[title] = {
      image_link: image_link,
      description: description,
      location: location,
      percent_funded: percent_funded
    }
  end

end


create_project_hash
