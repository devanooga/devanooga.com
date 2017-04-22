---
title: Annoying Mastodon Users with a Bot
layout: post
permalink:
author: Bobby Burden III <bobby@brb3.org>
---

Because of the recent influx of Japanese users on Mastodon, I wrote a bot to
translate their toots to English. In doing so, I was able to annoy a large
portion of the Mastodon user base unintentionally.

<!--excerpt-->

#### But Why?
[Mastodon][mastodon], the GNU Social compatible microblogging platform,
recently gained quite a bit of popularity. In the aftermath, a popular Japanese
blog [published an article][ascii] describing the service. Suddenly, the small
service was being flooded by excited Japanese users, sending out their "toots"
in their native tongue. This caused several users to be very annoyed by their
timeline suddenly being filled with Hiragana and the like.

I found it annoying that so many people were complaining about the Japanese
users on Mastodon. Why should they care? Just continue using it like you have
been, and ignore the toots you can't read.

I decided to take a tongue-in-cheek approach, and create a translation bot that
would reply to any toots in Japanese with a translated English version of the
status.

#### Translation API
To get this working, I would need some way of translating the toots. I decided
to go with [Microsoft's Translator API][translator-api]. It's not very accurate
for Japanese, so I decided to poke fun at this by using a Clippy image as the
bot's avatar.

![Clippy]({{ site.url }}/images/blog/clippy.jpg)

To follow along, setup an account with Microsoft, and get a token for the
translator API.

### Mastodon API

Mastodon privdes a nice Ruby gem on their [github][mastodon-api]. It's
[well documented][gem-docs], and works pretty nicely for this silly task. To
connect to a Mastodon instance, you need to authenticate as a user via Oauth.
This would normally be handled whenever a user connects to your "Mastodon app",
but since we are just building a bot (and not acting on behalf of a user) we
just need the Ruby script to have a token to toot as our translation bot's
mastodon account.

To setup the Oauth tokens:
1. Create a mastodon account. I used [mastodon.cloud][mastodon-cloud] for my
bot's instance.
2. Create your secret token with this [this tool][tinysubversions]. 
3. Hang onto the generated `access_token`.

### Getting started

First, let's get a Gemfile in place:
```ruby
source 'https://rubygems.org'                                                                                                                                                                                                           

gem 'mastodon-api', require: 'mastodon'                                          
gem 'curb'        
```

Now it's bundle time: `$ bundle install`

And we can setup the basics of our script.
```ruby
#!/usr/bin/env ruby
require 'mastodon'
require 'curb' # We'll need this for talking to Microsoft's Translator API

translator_token = '{TOKEN_FROM_TRANSLATOR_API}'
mastodon_token = '{ACCESS_TOKEN_FROM_MASTODON}'

# We're going to extend the String Class to do a bit of our dirty work
class String
  # We'll use this to strip XML/HTML tags out of strips
  def without_tags
    self.gsub(%r{</?[^>]+?>}, '')
  end

  # Use regex to check for Japanese Characters
  def japanese?
    # Using `!!` to make sure that we end up with a bool.
    # Also, \p will match Unicode properties. Here, we're looking for Japanese
    # characters.
    !!(self =~ /\p{Katakana}|\p{Hiragana}/)
  end
end
```

[mastodon]: https://mastodon.social/about
[ascii]: http://ascii.jp/elem/000/001/465/1465842/
[translator-api]: https://docs.microsoft.com/en-us/azure/cognitive-services/translator/text-overview
[mastodon-api]: https://github.com/tootsuite/mastodon-api
[gem-docs]: http://www.rubydoc.info/gems/mastodon-api/Mastodon
[mastodon-cloud]: https://mastodon.cloud/
[tinysubversions]: https://tinysubversions.com/notes/mastodon-bot/
