# Download photos example
# Matthew Epler, Sept 2012
# Based on "Picasa" gem by Wojciech Wnętrzak - http://rubygems.org/gems/picasa

require "picasa"
require 'open-uri'

username = "matthewepler@gmail.com"
dir = "/Users/matthewepler/Desktop/picasa_albums/"

begin
  
  client = Picasa::Client.new(:user_id => username)
  albums = client.album.list.entries
  
  albums.each do |album|  	
  	Dir.chdir(dir)
  	this_album = client.album.show(album.id).entries
  	Dir.mkdir( album.title )
  	Dir.chdir( album.title )

  		for photo in this_album
  			begin
  				get_string = photo.content.src
  				puts "processing" << photo.id

  			rescue Exception=>e 
  				puts photo.id << "  **ERROR**"
  				puts e
  			end

			open(get_string	) {|f|
   				File.open(photo.title, "wb") do |file|
    			file.puts f.read
   				end
			} 	 
			puts "======================================"
		end
end


rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end


