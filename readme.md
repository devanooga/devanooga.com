[![Stories in Ready](https://badge.waffle.io/devanooga/devanooga.github.io.png?label=ready&title=Ready)](https://waffle.io/devanooga/devanooga.github.io)
# Requirements

* Ruby
* Nodejs

To run the application after pulling:

1. `bundle install`
2. `bundle exec jekyll serve`

And access the application at http://localhost:4000/

# Submitting your member profile

Unfamiliar/uncomfortable with Git/Github and pull requests? Feel free to open an issue with the below values filled out or ask on Slack.

---

Member data is located under _data/members, copy a profile and fill it out, variables include:

* name - The name as it displays on the site.
* gravatar - Your gravatar hash, use a tool like http://aruljohn.com/gravatar/, for example my result is `http://www.gravatar.com/avatar/6789f8bd72612e941f9a7ae6f414b2ea?s=48&d=identicon`, the hash is this part: `6789f8bd72612e941f9a7ae6f414b2ea`.
* github - (optional) Github account name.
* bitbucket - (optional) Bitbucket account name.
* gitlab - (optional) Gitlab account name.
* twitter - (optional) Twitter account name.
* linkedin - (optional) LinkedIn account name, for example `https://www.linkedin.com/in/MyAccountHere` would be `MyAccountHere`
* stackoverflow - (optional) StackOverflow account name.

If you have recommendations for new fields, please submit an issue or a pull request!