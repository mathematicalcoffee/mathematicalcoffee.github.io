# How to use this template

## Setup

Edit:

* `_config.yml`:
  - change site title, name, etc
  - add as many authors as you like using `rake add_author`.
    You can add social media information (twitter etc) and it's shown in the sidebar 'about me' section.
    Then you can use (e.g.) `authors: [john, jane]` in a post to set the author for that post.
  - `social-post`: which sites (from `_data/social.yml`) we provide 'share' links on.
  - `disqus_shortname`: the shortname you've set on disqus to use for comments for this site.
* `_includes/EDIT.navbar.html`: what links are placed into the navbar
* `_includes/EDIT.footer.text.md`: text placed in the site footer (markdown)

Then:

```
bundle install
rake generate
```

Finally

```
bundle exec jekyll serve --watch
```

## Making a new post
## Enabling comments

Set `comments: true` in the YAML frontmatter to turn on commenting.
