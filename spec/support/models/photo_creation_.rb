def create_photo(attributes= {})
  defaults = {
    user_id: 1,
    url: 'http://38.media.tumblr.com/cd185de01d048ec0c6f8e17afcbcded9/tumblr_n7fgm42wxi1st5lhmo1_1280.jpg'
  }
  Photo.create!(defaults.merge(attributes))
end