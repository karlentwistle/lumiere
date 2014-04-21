[![Build Status](https://api.travis-ci.org/karlentwistle/lumiere.png?branch=master)](http://travis-ci.org/karlentwistle/lumiere)

## TODO
* Investigate rspec shared examples I be able to include from for acts_as_accessible?
* Add playlist support for Vimeo (new_from_video_id)
* Add date methods to providers
* Rename fetch_video_id in Vimeo and Youtube class
* Lots of duplication in the YouTube and YouTubePlaylist could be good to move YouTube out to YouTubeVideo and have YouTube as a common base class.......
* Refactor YouTube to recognize embed links with
* Refactor Vimeo to recognize embed links with
* Get the VCR cassets down to a single request per file
* Add support for YouTube playlist with more than 25 videos
