# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'rest-client'

url = "https://api.themoviedb.org/3/movie/top_rated"


# curl --request GET \
#      --url 'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1' \
#      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGRjZmIyYjcyODNjMTM0ZDNmYTIzNWI0MmNhYzI4NSIsIm5iZiI6MTczMTU5MzU2MC42MjY4MTI1LCJzdWIiOiI2NzM2MDRjNWIwNDI5N2Y3MGM2ODM4OGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NJZdbfr_TN6oqJq3FfHtbdO408rEnV4eH7bFKtP19X0' \
#      --header 'accept: application/json'

def get_response(url)
  begin
    return RestClient.get(url, headers={ Authorization: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGRjZmIyYjcyODNjMTM0ZDNmYTIzNWI0MmNhYzI4NSIsIm5iZiI6MTczMTU5MzU2MC42MjY4MTI1LCJzdWIiOiI2NzM2MDRjNWIwNDI5N2Y3MGM2ODM4OGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NJZdbfr_TN6oqJq3FfHtbdO408rEnV4eH7bFKtP19X0'})
  rescue RestClient::GatewayTimeout
    "GatewayTimeout"
  rescue RestClient::RequestTimeout
    "RequestTimeout"
  rescue SocketError
    "SocketError"
  end
end
url_response = get_response(url)
movies = JSON.parse(url_response.body)



movies["results"].each do |tmdb|
  Movie.create(title: tmdb["original_title"], overview: tmdb["overview"], poster_url:"https://image.tmdb.org/t/p/original#{tmdb["poster_path"]}", rating: tmdb["vote_average"] )
end
