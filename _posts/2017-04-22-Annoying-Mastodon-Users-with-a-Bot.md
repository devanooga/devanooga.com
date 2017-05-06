---
title: Annoying Mastodon Users with a Bot
layout: post
permalink: /blog/2017/04/22/annoying-mastodon-users-with-a-bot
author: bobby_brb3 
date: 2017-04-22
redirect_from:
  - /2017/04/22/annoying-mastodon-users-with-a-bot
---

Because of the recent influx of Japanese users on Mastodon, I wrote a bot to
translate their toots to English. This was a useful learning experience, and in
this post I walk through the process of creating a Ruby script to work with
Mastodon's API.

<!--excerpt-->

#### But Why?
[Mastodon][mastodon], the GNU Social compatible microblogging platform,
recently gained quite a bit of popularity. In the aftermath, a popular Japanese
blog [published an article][ascii] describing the service. Suddenly, the small
service was being flooded by excited Japanese users, sending out their "toots"
in their native tongue. This caused several users to be very annoyed by their
timeline suddenly being filled with Hiragana and the like.

It's a bit odd that so many people were complaining about the Japanese users on
Mastodon. Why should they care? Just continue using it like you have been, and
ignore the toots you can't read.

I decided to take a tongue-in-cheek approach, and create a translation bot that
would reply to any toots in Japanese with a translated English version of the
status.

#### Translation API
To get this working, I would need some way of translating the toots. I decided
to go with [Microsoft's Translator API][translator-api]. It's not very accurate
for Japanese (or at least, it doesn't seem to be), so I decided to poke fun at
this by using a [Clippy][clippy] image as the bot's avatar.

![Clippy](/images/blog/2017-04-22-annoying-mastadon-users-with-a-bot/clippy.jpg)

To follow along, setup an account with Microsoft, and get a token for the
translator API.

### Mastodon API

Mastodon privdes a nice Ruby gem on their [GitHub][mastodon-api]. It's
[well-documented][gem-docs], and works pretty nicely for this silly task. To
connect to a Mastodon instance, you need to authenticate as a user via Oauth.
This would normally be handled whenever a user connects to your "Mastodon app",
but since we are just building a bot (and not acting on behalf of a user) we
just need the Ruby script to use a token to toot as our translation bot's
mastodon account.

To setup the Oauth tokens:
1. Create a mastodon account. I used [mastodon.cloud][mastodon-cloud] for my
bot's instance.
2. Create your secret token with this [this tool][tinysubversions]. 
3. Hang onto the generated `access_token`.

### Writing the Bot

First, let's get a Gemfile in place:
```ruby
source 'https://rubygems.org'

gem 'mastodon-api', require: 'mastodon'
gem 'curb'
```

Now it's bundle time: `$ bundle install`

And we can set up the basics of our script. This is simple enough that we can
build the entire program in one file. I named mine `bot.rb`, but feel free to be
more creative with your naming than me.

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

Now we'll add some methods to handle the interaction with the Microsoft
Translator API.

```ruby
# Gets an access token for the Translator API
def get_token(translator_token)
  token_url = "https://api.cognitive.microsoft.com/sts/v1.0/issueToken"
  response = Curl.post(token_url) do |response|
    response.headers['Ocp-Apim-Subscription-key'] = translator_token
  end

  return response.body_str
end

# Connects to the API and translate the toot's content.
# If there's an issue with the connection, we return `false`
def translate_toot(toot, token)
  toot_content = toot.content.without_tags
  translation_url = 
    "http://api.microsofttranslator.com/v2/Http.svc/Translate?" +
    "text=" + toot_content + "&to=en&from=ja"

  begin
    response = Curl.get(translation_url) do |response|
      response.headers['Authorization'] = "Bearer " + token
    end
  rescue
    return false
  end

  if response.status != "200 OK"
    return false
  end

  return response.body_str.without_tags
end
```

With that in place, we can set up our basic program logic.
It needs to:
- Connect to Mastodon and grab some toots to chew on
- Decide which toots are in Japanese
- Connect to Microsoft and get a fresh access token
- Translate the Japanese toots
- Reply to the Japanese toots with the Translator API translation.

```ruby
# Connect to mastodon
mastodon = Mastodon::REST::Client.new(
  base_url: 'https://mastodon.cloud', bearer_token: mastodon_token
)

# Grab the 25 most recent toots from the Public Timeline
toots = mastodon.public_timeline(limit:25)

# Find all of the Japanese toots and translate them
japanese_toots = []
token = get_token(translator_token)
toots.each do |toot|
  toot_content = toot.content.without_tags
  if toot_content.japanese?
    translated = translate_toot(
      toot, token
    )
    if translated
      japanese_toots << [toot, translated]
    end
  end
end

# Loop through the Japanese toots and start replying
japanese_toots.each do |toot|
  begin
    # toot[1] is the translated content of the toot
    translated_toot = "English Translation:\n" + toot[1]

    # Make sure we don't go over the maximum toot length
    if translated_toot.length <= 500
      # toot[0] is the original toot we are replying to
      mastodon.create_status(
        translated_toot,
        toot[0].id
      )
      puts "Tooted @ " + toot[0].account.acct
    end
  rescue
    puts "Failed tooting!"
  end
end
```

You can see the completed script in [this gist][gist]. All you need to do to run
this script is to create the `Gemfile`, run `bundle install`, then add the code
to your `bot.rb`. Next, you need to make the file executable. On Unix-like
systems, you can run `chmod +x bot.rb`. Finally, run the script with `./bot.rb`.

You can also skip the [chmod][chmod] step and run the script with `ruby bot.rb`.
But I prefer the [shebang][shebang] method (adding the `#!` line at the top of
the script) since it provides a uniform way of running scripts on your system
regardless of the language it is written in. With the shebang line in place,
your shell knows to pass the contents of the file to the `ruby` interpreter to
process and execute the file.

For simplicity's sake, the script described in this post runs once, then must be
ran again to fetch 25 new toots. I wrote a slightly different version of it that
pulls in the tokens from a JSON file, and also continuously loops to toot out
replies to new statuses as they come in. If you'd like to take a look at that
script, check it out in [this repo][translator-bot].

### In action

I ran this bot for a few days under the handle
[@japanesetranslator][translator]. It seemed to annoy a few
[instance admins][annoy], since it sent out so many toots. So be warned that if
you run a similar bot, you might get your bot or your instance banned. Have fun!


[mastodon]: https://mastodon.social/about
[ascii]: http://ascii.jp/elem/000/001/465/1465842/
[translator-api]: https://docs.microsoft.com/en-us/azure/cognitive-services/translator/text-overview
[mastodon-api]: https://github.com/tootsuite/mastodon-api
[gem-docs]: http://www.rubydoc.info/gems/mastodon-api/Mastodon
[mastodon-cloud]: https://mastodon.cloud/
[tinysubversions]: https://tinysubversions.com/notes/mastodon-bot/
[gist]: https://gist.github.com/brb3/e26bedb15b4e0ddf22645874ce5ba164 
[translator-bot]: https://github.com/brb3/translator-bot 
[translator]: https://mastodon.cloud/@japanesetranslator
[clippy]: https://en.wikipedia.org/wiki/Office_Assistant
[chmod]: https://en.wikipedia.org/wiki/Chmod
[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
[annoy]: https://cybre.space/users/nightpool/updates/13509
