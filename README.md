Edit:

* `_config.yml`:
  - change site title, name.
  - can add as many authors as you like (with as much social information as you like).
    Use 'authors: <key>' in the YAML of a post to look up their information for the footer.
    Social information is used in the 'about me' social sidebar (what is shown is controlled
    by what you supply and what is in _config.yml `social-aboutme`).

        authors: [john, jane]

  - `social-post`: which sites (from `_data/social.yml`) we provide 'share' links on.
* `_includes/EDIT.navbar.html`: what links are placed into the navbar
* `_includes/EDIT.footer.text.md`: text placed in the site footer (markdown)
* `_includes/EDIT.disqus.html`: to enable disqus commenting, edit this to include your disqus shortname. Also, in any post you wish to enable comments, set `comments: true` in the frontmatter.

Then:

```
bundle install
rake generate
```

Finally

```
bundle exec jekyll serve --watch
```
