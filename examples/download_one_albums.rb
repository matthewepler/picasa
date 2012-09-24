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
  
  album = albums.find { |album| album.title == "album_name" }
  photos = client.album.show(album.id).entries

  photos.each do |photo| 
    begin
  		get_string = photo.content.src
  		puts "processing" << photo.id

 			rescue Exception=>e 
 				puts photo.id << "  **ERROR**"
 				puts e
 			end

      Dir.chdir(dir)
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


