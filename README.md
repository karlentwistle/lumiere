[![Gem Version](https://badge.fury.io/rb/lumiere.png)](http://badge.fury.io/rb/lumiere) [![Build Status](https://travis-ci.org/karlentwistle/lumiere.png?branch=master)](https://travis-ci.org/karlentwistle/lumiere) [![Dependency Status](https://gemnasium.com/karlentwistle/lumiere.png)](https://gemnasium.com/karlentwistle/lumiere) [![Code Climate](https://codeclimate.com/github/karlentwistle/lumiere.png)](https://codeclimate.com/github/karlentwistle/lumiere) [![Coverage Status](https://coveralls.io/repos/karlentwistle/lumiere/badge.png?branch=master)](https://coveralls.io/r/karlentwistle/lumiere)

# Lumiere

Lumiere fetches metadata from video providers

* YouTube (with playlist support)
* Vimeo

Install
--------

``` bash
gem install lumiere
```

Usage
-----

``` ruby
video = Elluminate.new('https://www.youtube.com/watch?v=6sJ80Y1YLJY')
# video.accessible?      => true
# video.video_id         => '6sJ80Y1YLJY'
# video.provider         => 'YouTube'
# video.title            => "enduser - End of A Beginning (Sublight Version)"
# video.description      => "enduser - End of A Beginning (Sublight Version)"
# video.duration         => 367
# video.thumbnail_small  => "http://i1.ytimg.com/vi/6sJ80Y1YLJY/default.jpg"
# video.thumbnail_medium => "http://i1.ytimg.com/vi/6sJ80Y1YLJY/mqdefault.jpg"
# video.thumbnail_large  => "http://i1.ytimg.com/vi/6sJ80Y1YLJY/hqdefault.jpg"
# video.embed_url        => "http://www.youtube.com/embed/6sJ80Y1YLJY"
# video.embed_code       => "<iframe src="//www.youtube.com/embed/6sJ80Y1YLJY" frameborder="0" allowfullscreen></iframe>"

playlist = Elluminate.new('https://www.youtube.com/playlist?list=PL4AEB04ABEB34B5EC')
# playlist.videos           => [Array of YouTube videos]
# playlist.videos.count     => 32
# playlist.accessible?      => true
# playlist.playlist_id      => 'PL4AEB04ABEB34B5EC'
# playlist.title            => "Mat Zo Anjunabeats Playlist"
# playlist.description      => "A playlist covering Mat Zo's releases on Anjunabeats"
# playlist.thumbnail_small  => "http://i.ytimg.com/vi/B0bXdMQlrEY/default.jpg"
# playlist.thumbnail_medium => "http://i.ytimg.com/vi/B0bXdMQlrEY/mqdefault.jpg"
# playlist.thumbnail_large  => "http://i.ytimg.com/vi/B0bXdMQlrEY/hqdefault.jpg"
# playlist.embed_url        => "http://youtube.com/embed/?list=PL4AEB04ABEB34B5EC"
# playlist.embed_code       => "<iframe src=\"//youtube.com/embed/?list=PL4AEB04ABEB34B5EC\" frameborder=\"0\" allowfullscreen></iframe>"

video = Elluminate.new("http://vimeo.com/4268592")
# video.accessible?      => true
# video.video_id         => '4268592'
# video.provider         => 'Vimeo'
# video.title            => "Alan Watts"
# video.description      => "Alan Watts&#13;<br />\n&#13;<br />\n&#13;<br />\nSo true.&#13;"
# video.duration         => 141
# video.thumbnail_small  => "http://i.vimeocdn.com/video/9464045_100x75.jpg"
# video.thumbnail_medium => "http://i.vimeocdn.com/video/9464045_200x150.jpg"
# video.thumbnail_large  => "http://i.vimeocdn.com/video/9464045_640.jpg"
# video.embed_url        => "http://player.vimeo.com/video/4268592"
# video.embed_code       => "<iframe src=\"//player.vimeo.com/video/4268592\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"

playlist = Elluminate.new('https://vimeo.com/album/1488772')
# playlist.videos           => [Array of Vimeo videos]
# playlist.videos.count     => 6
# playlist.accessible?      => true
# playlist.playlist_id      => '1488772'
# playlist.title            => "STEPHEN HAWKING'S UNIVERSE"
# playlist.description      => "Descubre el universo de la mano de Stephen Hawking"
# playlist.thumbnail_small  => "http://i.vimeocdn.com/video/134668334_100x75.jpg"
# playlist.thumbnail_medium => "http://i.vimeocdn.com/video/134668334_200x150.jpg"
# playlist.thumbnail_large  => "http://i.vimeocdn.com/video/134668334_640.jpg"
# playlist.embed_url        => "http://player.vimeo.com/hubnut/album/1488772"
# playlist.embed_code       => "<iframe src=\"//player.vimeo.com/hubnut/album/1488772?autoplay=0&byline=0&portrait=0&title=0\" frameborder=\"0\"></iframe>"
```

Author
------

[Karl Entwistle](https://github.com/karlentwistle) ([@karlentwistle](https://twitter.com/karlentwistle))

Contributors
------------

[https://github.com/karlentwistle/lumiere/graphs/contributors](https://github.com/karlentwistle/lumiere/graphs/contributors)

## TODO
* VimeoPlaylist to render videos using Vimeo class, not OpenStruct
* VimeoPlaylist to page through videos

## Known Limits
* Vimeo Playlist can only support a maximum of 60 videos results through the 'simple API'
