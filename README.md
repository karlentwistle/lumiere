[![Build Status](https://api.travis-ci.org/karlentwistle/lumiere.png?branch=master)](http://travis-ci.org/karlentwistle/lumiere)

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
video = Elluminate.new('https://www.youtube.com/watch?v=NwRuI0yjreQ')
# video.accessible?      => true
# video.provider         => 'YouTube'
# video.title            => "Shock haircut Supermodel punishment"
# video.description      => "Supermodels are forced to cut their long locks and burst into tears. Fashion makeover or Punishment?"
# video.duration         => 419
# video.thumbnail_small  => "http://i1.ytimg.com/vi/NwRuI0yjreQ/default.jpg"
# video.thumbnail_medium => "http://i1.ytimg.com/vi/NwRuI0yjreQ/mqdefault.jpg"
# video.thumbnail_large  => "http://i1.ytimg.com/vi/NwRuI0yjreQ/hqdefault.jpg"
# video.embed_url        => "http://www.youtube.com/embed/NwRuI0yjreQ"
# video.embed_code       => "'<iframe src="//www.youtube.com/embed/NwRuI0yjreQ" frameborder="0" allowfullscreen></iframe>'"

video = Elluminate.new("http://vimeo.com/4268592")
# video.accessible?      => true
# video.provider         => 'Vimeo'
# video.title            => "Alan Watts"
# video.description      => "Alan Watts&#13;<br />\n&#13;<br />\n&#13;<br />\nSo true.&#13;"
# video.duration         => 141
# video.thumbnail_small  => "http://i.vimeocdn.com/video/9464045_100x75.jpg"
# video.thumbnail_medium => "http://i.vimeocdn.com/video/9464045_200x150.jpg"
# video.thumbnail_large  => "http://i.vimeocdn.com/video/9464045_640.jpg"
# video.embed_url        => "http://player.vimeo.com/video/4268592"
# video.embed_code       => "<iframe src=\"//player.vimeo.com/video/4268592\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
```

Author
------

[Karl Entwistle](https://github.com/karlentwistle) ([@karlentwistle](https://twitter.com/karlentwistle))

Contributors
------------

[https://github.com/karlentwistle/lumiere/graphs/contributors](https://github.com/karlentwistle/lumiere/graphs/contributors)


## TODO
* Add playlist support for Vimeo (new_from_video_id)
* Add date methods to providers
* Refactor Vimeo to recognize embed links
