def youtube_embed(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
  else
    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    youtube_id = $5
  end

  raw("<iframe title=\"YouTube video player\" width=\"640\" height=\"390\" src=\"http://www.youtube.com/embed/#{ youtube_id }\" frameborder=\"0\" allowfullscreen></iframe>")
end

#youtube_embed('youtu.be/jJrzIdDUfT4')
# => <iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/jJrzIdDUfT4" frameborder="0" allowfullscreen></iframe>
