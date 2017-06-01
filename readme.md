[![Stories in Ready](https://badge.waffle.io/devanooga/devanooga.github.io.png?label=ready&title=Ready)](https://waffle.io/devanooga/devanooga.github.io)
# Requirements

* Ruby
* Nodejs

To run the application after pulling:

1. `bundle install`
2. `bundle exec jekyll serve`

And access the application at http://localhost:4000/

# Submitting your member profile

**Note:** Unfamiliar/uncomfortable with Git/Github and pull requests? Feel free to open an issue with the below values filled out or ask on Slack.

---

Member data is located under `_collections/members`. Copy an existing profile, name it something unique (preferably using your username on the devanooga Slack) and fill it out using these properties:

- **`name`** (required) Your full name as it should appear on the site.
- **`gravatar`** (required) Your gravatar hash. [Use this tool to get your gravatar hash.](http://aruljohn.com/gravatar/) _For example, @StrangeWill’s result is `http://www.gravatar.com/avatar/6789f8bd72612e941f9a7ae6f414b2ea?s=48&d=identicon`; the hash is this part: `6789f8bd72612e941f9a7ae6f414b2ea`._
- **`website`** (optional) The full URL (including the protocol: `http://` or `https://`) to your website.
- **`profile:`**
    - **`github`** (optional) Github account name.
    - **`bitbucket`** (optional) Bitbucket account name.
    - **`gitlab`** (optional) Gitlab account name.
    - **`twitter`** (optional) Twitter account name.
    - **`linkedin`** (optional) LinkedIn account name, for example `https://www.linkedin.com/in/MyAccountHere` would be `MyAccountHere`
    - **`stackoverflow`** (optional) StackOverflow account name.

If you have recommendations for new fields, please submit an issue or a pull request!

# Running tests

Before a PR will be merged, it must be passing tests. We have the best tests, don't we folks?

To run tests in your dev environment, execute `bundle exec rake tests`.

You can create new tests in the `test` directory.
