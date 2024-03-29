# Requirements

* Ruby
* Bundler

To run the application after pulling:

1. `bundle install`
2. `bundle exec jekyll serve`

And access the application at http://localhost:4000/

# Submitting your member profile

**Note:** Unfamiliar/uncomfortable with Git/Github and pull requests? Feel free to open an issue with the below values filled out or ask on Slack.

---

Member data is located under `_collections/members`. Copy an existing profile, name it something unique (preferably using your username on the devanooga Slack) and fill it out using these properties:

- **`name`** (required) Your full name as it should appear on the site.
- **`gravatar`** (required) Your gravatar hash. Gravatar provides a single repository for your internet-wide avatar. We use this to display a picture of you on our members page. [Use this tool](https://en.gravatar.com/site/check/) to get your gravatar hash. After you enter your email address and click the _Check_ button, the tool will display some information below the form. The value you need is the one labeled Email Hash. (For example, @StrangeWill’s email hash is `6789f8bd72612e941f9a7ae6f414b2ea`.)
- **`members-quilt`** (optional: true/false) Whether you would like to appear in the members quilt on our homepage.
- **`website`** (optional) The full URL (including the protocol: `http://` or `https://`) to your website.
- **`profile:`**
    - **`github`** (optional) Github account name.
    - **`bitbucket`** (optional) Bitbucket account name.
    - **`gitlab`** (optional) Gitlab account name.
    - **`twitter`** (optional) Twitter account name.
    - **`linkedin`** (optional) LinkedIn account name, for example `https://www.linkedin.com/in/MyAccountHere` would be `MyAccountHere`
    - **`stackoverflow`** (optional) StackOverflow account name.

If you have recommendations for new fields, please submit an issue or a pull request!

# Submitting your project

Project data is located under `_collections/projects`. To get started, just copy an existing project markdown file, rename it match your project name, then fill out these properties:

- **`name`** (required) The name of your project.
- **`website`** (required) The website where your project is hosted. Either a deployed project or a git repository.
- **`source`** (optional) URL to the source code.
- **`member`** (required) Your member name. This is used to assign attribution and link to your profile on our member page.
- **`description`** (optional) A brief description of your project.
- **`image`** (required) A link to an image that represents your project.

# Running tests

Before a PR will be merged, it must be passing tests. We have the best tests, don't we folks?

To run tests in your dev environment, execute `bundle exec rake test`.

You can create new tests in the `test` directory.
