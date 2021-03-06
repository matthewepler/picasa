# Picasa

Ruby library for [Picasa Web Albums Data API](https://developers.google.com/picasa-web/)

## Installation

```
gem install picasa
```

## Usage

[Documentation](http://rubydoc.info/github/morgoth/picasa)

``` ruby
client = Picasa::Client.new(user_id: "username@gmail.com")
client.album.list
# => Picasa::Presenter::AlbumList

client.album.show("album_id")
# => Picasa::Presenter::Album

client.photo.create("album_id", file_path: "path/to/my-photo.png")
# => Picasa::Presenter::Photo
```

### Authentication

When request is authenticated, response will contain private data, however this can be controlled by `access` parameter.

You can authenticate by specifing password:

```ruby
client = Picasa::Client.new(user_id: "some.user@gmail.com", password: "secret")
```

Or by setting custom authorization header, i.e. taken from OAuth authentication:

```ruby
client = Picasa::Client.new(user_id: "some.user@gmail.com", authorization_header: "OAuth token")
```

## Extra

You can install thor script for uploading all photos from given directory:

```
thor install https://github.com/morgoth/picasa/raw/master/extra/Thorfile --as imagery --force
```

Updating script can be done by:

```
thor update imagery
```

And then use it (it will create album taking title from folder name and upload all photos from that directory):

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_PASSWORD=secret thor imagery:upload path-to-folder-with-photos
# Without specifing password
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_AUTHORIZATION_HEADER="GoogleLogin auth=token" thor imagery:upload path-to-folder-with-photos
```

If your upload was somehow interrupted, you can resume it by adding `--continue` option:

```
GOOGLE_USER_ID=your.email@gmail.com GOOGLE_PASSWORD=secret thor imagery:upload --continue path-to-folder-with-photos
```

If you run out of quota and want to resize images to fit Picasa free storage limits, you can install `rmagick` gem and run (this will modify files):

```
thor imagery:resize path-to-folder-with-photos
```

## Caveats

Currently picasa wont work with `ox` xml parser.

Using `rexml` parser wont return `etag` attribute properly.

I recommend to use `libxml` or `nokogiri`.

## Continuous Integration
[![Build Status](https://secure.travis-ci.org/morgoth/picasa.png)](http://travis-ci.org/morgoth/picasa)

## Contributors

* [Bram Wijnands](https://github.com/Bram--)
* [Rafael Souza](https://github.com/rafaels)
* [jsaak](https://github.com/jsaak)
* [Javier Guerra](https://github.com/javierg)
* [Eiichi Takebuchi](https://github.com/GRGSIBERIA)

## Copyright

Copyright (c) Wojciech Wnętrzak, released under the MIT license.
