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
# video.embed_code       => "'<iframe src="//www.youtube.com/embed/6sJ80Y1YLJY" frameborder="0" allowfullscreen></iframe>'"

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
```

Author
------

[Karl Entwistle](https://github.com/karlentwistle) ([@karlentwistle](https://twitter.com/karlentwistle))

Contributors
------------

[https://github.com/karlentwistle/lumiere/graphs/contributors](https://github.com/karlentwistle/lumiere/graphs/contributors)


## TODO
* Add playlist support for Vimeo (new_from_video_id)
