require 'csv'
require 'date'
require 'httparty'

    neighborhoods = []
    nooklyn_neighborhoods = JSON(HTTParty.get("https://nooklyn.com/api/v1/neighborhoods/").parsed_response)['data']
    nooklyn_neighborhoods.each do |neighborhood|
        neighborhoods << { id: neighborhood['id'], name: neighborhood['attributes']['name'] }
    end

    puts "Currently checking avaiable listsings on Nooklyn..."
    available_rooms = JSON(HTTParty.get('https://nooklyn.com/api/v1/listings').parsed_response)

    puts "We've found #{available_rooms['data'].count} listings."
    CSV.open("Nooklyn Available Listings_#{Date.today.to_s}.csv", 'wb') do |csv|
      csv << ["Room Id",
              "Neighborhood",
              "Url",
              "Bathrooms",
              "Bedrooms",
              "Price",
              "Price Per Bedroom",
              "Thumbnail",
              "Subway Lines",
              "Nearest Stop",
              "Amenities",
              "Last Updated"]

      puts "Filtering this data for the last 30 days into your CSV now..."
      available_rooms['data'].each do |room|
        next if room['attributes']['residential'] == false || room['attributes']['status'] ==  "Rented" || (Date.today - Date.parse(room['attributes']['updated-at'].slice(0, 10))).to_i  > 30
        id = room['id']
        neighborhood = neighborhoods[room['relationships']['neighborhood']['data']['id'].to_i - 1][:name]
        url = "https://nooklyn.com/listings/#{id}"
        bathrooms = room['attributes']['bathrooms']
        bedrooms = room['attributes']['bedrooms']
        price = room['attributes']['price']
        price_per_bedroom = price/bedrooms
        thumbnail = room['attributes']['primary-thumbnail']
        subway_lines = room['attributes']['subway-line']
        nearest_stop = room['attributes']['station']
        amenities = room['attributes']['amenities']
        last_updated = room['attributes']['updated-at']

      csv << [id,
              neighborhood,
              url,
              bathrooms,
              bedrooms,
              price,
              price_per_bedroom,
              thumbnail,
              subway_lines,
              nearest_stop,
              amenities,
              last_updated]
      end
      puts "All done! Check the 'Nooklyn Available Listings_#{Date.today.to_s}.csv' file in this directory."
    end
