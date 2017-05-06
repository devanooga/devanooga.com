---
title: How to Post to the Devanooga Blog
layout: post
permalink: /blog/2017/04/17/how-to-post-to-the-devanooga-blog
author: ryanmaynard
redirect_from:
  - /2017/04/17/how-to-post-to-the-devanooga-blog
---

In an attempt to add value to the devanooga community, a few members suggested that a blog be created. If you would like to contribute, here are a few instructions on how you can go about that. 

<!--excerpt-->

#### Filename
Jekyll posts are written in Markdown, so open your preferred markdown editor and create a file in the following format:

`YYYY-MM-DD-post-title.md`

###### Caveat: The filename can not be in titlecase. 


#### Front Matter
At the top of the file, make sure to include your [YAML Front Matter][frontmatter]. Here is the front matter for this article:

```
---
title: How to Post to the Devanooga Blog
layout: post
permalink:
author: Ryan Maynard
date: 2017-04-17
---
```

#### Excerpt

By default, Jekyll will grab the first fifty words of your post for the excerpt. If you would like more granular control of that, you can use the excerpt tag.

 ``` 
 Some text shown in your post excerpt. 
 
 <!--excerpt-->
 
 The rest of the post.
 ```
 
#### Markdown
 
While writing your post, you may need a [quick Markdown syntax refresher][markdownrefresher].  
 
#### Github

To add your post, you'll need to fork the [devanooga site repo][devanoogarepo] on Github. If you are uncomfortable with Git, feel free to ask someone for help in the [devanooga slack][devanoogaslack].  

#### Directory Structure

You'll add your post to the `_posts` directory, and your images, if any, to the `images/blog/<postname>` directory.

```
├── _posts
│   └── 2017-04-17-post-name.md
└── images
    ├── blog
    │   └── 2017-04-17-post-name
    │       ├── blog_image1.png
    │       └── blog_image2.png
    ├── devanooga_logo.png
    ├── devanooga_logo.svg
    ├── favicon.png
    ├── menu_sammich.svg
    ├── social_icons.svg
    └── you.png

```

#### Submission

Make a final check for grammar and spelling, then open a [Pull Request][pull]. 

[frontmatter]: https://jekyllrb.com/docs/frontmatter/
[markdownrefresher]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
[devanoogarepo]: https://github.com/devanooga/devanooga.com
[devanoogaslack]: https://www.devanooga.com/slack/
[pull]: https://github.com/devanooga/devanooga.com/pulls
