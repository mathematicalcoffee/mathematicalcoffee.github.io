---
layout: default
title: Hello World!
tagline: Supporting tagline
---
doop-di-doop-di-doo.

Here's a sample "posts list".

<ul class="posts">
  {% for post in site.posts %}
    {% include post-short.html %}
  {% endfor %}
</ul>

## To-Do

- [ ] google analytics
- [x] sidebar widget configuration in `_config.yml`
- [ ] remove obscene amounts of whitespace between tags https://github.com/penibelst/jekyll-compress-html
- [ ] get custom CSS: http://getbootstrap.com/customize/
- [ ] use modals for popups for social bar
- [ ] use same code for post layout in post page and blog listing page.
- [x] post footer: likes, poster, ...
- [x] disqus comments
- [ ] 'follow blog' links (PLUS RSS)
- [ ] 'like' per-post links
- [ ] sidebar:
    - [x] post archive
    - [x] social
    - [ ] followers
    - [ ] popular posts
    - [x] label cloud
- [ ] RMD compiling
- [x] fix up headings
- [x] Colours from Awesome.inc
- [x] navbar dropdown styling: make sure collapsing it undoes the styling
- [ ] fix MS gradients on navbar
- [x] sidebar styling
- [x] hosted by github/powered by jekyll/designed with bootstrap/copyright me footer
- [ ] searching:
    - [ ] tags (/search/tag/<tag>): tag cloud or list at the end of the post
    - [ ] categories (/search/category/<category>): category cloud or list at the end of the post
    - [ ] author (/search/author/<author>): click author name, also about page, maybe sidebar
    - [ ] text search (?) (/search/<text>): from blog archive widget (?)
    - [ ] date search (?) (/search/{date,month}/<date,month>): from blog archive widget (?)

## stretch goals

- [x] try with multiple authors
- [ ] dropdown on author-social with more social when it doesn't fit on one line.

Comments, BASE_PATH for github:

http://jekyllbootstrap.com/usage/blog-configuration.html

```
git checkout skellington
git checkout -b myfeaturebranch
git merge --no-ff myfeaturebranch
git branch -d myfeaturebranch
```

{% raw %}
```
sed -ire 's!\{\{([^ ])!{{ \1!g' `find -name '*.html'`
sed -ire 's!([^ ])\}\}!\1 }}!g' `find -name '*.html'`
```

{{ site.posts | map:'tags' }}

{% endraw %}
