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

- [ ] site.title not site.name?
- [ ] google analytics
- [ ] Jekyll 2.0 now supported on gh-pages: use bootstrap-sass rather than css?
- [ ] listing of /all/ posts?
- [ ] get custom CSS: http://getbootstrap.com/customize/
- [ ] use modals for popups for social
- [ ] 'follow blog' links (PLUS RSS)
- [ ] 'like' per-post links
- [ ] sidebar:
    - [x] post archive
    - [x] social
    - [ ] followers
    - [ ] popular posts
    - [x] label cloud
- [ ] RMD compiling
- [ ] fix MS gradients on navbar
- [ ] prettify seach result listings: headings only, or excerpts allowed.
- [x] **big todo**: newline in file seems to be treated as `<br />`? (if I turn off GFM then it's fine)
- [x] use same code for post layout in post page and blog listing page.
- [x] remove obscene amounts of whitespace between tags https://github.com/penibelst/jekyll-compress-html
    * [x] respace out liquid for readability.
- [x] use `where` filter in templates: `site.posts | where: "graduation_year", "2014"` ? (can't: only for `property == value`, not for `property contains value`)
- [x] migrate rakefile to `_templates`
- [x] **Big todo: handleize/handle filter appear not to work**
- [x] RSS feeds and also per category (per label?)
    * [x] links in HTML header to atom/rss (autodiscovery)
    * [x] subscribe button somewhere
- [x] update RSS to use filter date_to_rfc822
- [x] atom /feeds/atom.xml
- [x] sidebar widget configuration in `_config.yml`
- [x] post footer: likes, poster, ...
- [x] disqus comments
- [x] fix up headings
- [x] Colours from Awesome.inc
- [x] navbar dropdown styling: make sure collapsing it undoes the styling
- [x] sidebar styling
- [x] hosted by github/powered by jekyll/designed with bootstrap/copyright me footer
- [x] searching:
    - [stretch goal] fulltext search (via search bar)
    - [x] tags (/tag/{tag}): tag cloud or list at the end of the post
    - [x] categories (/category/{category}): category cloud or list at the end of the post
    - [x] author (/author/{author}): click author name, also about page, maybe sidebar
    - [x] date search (?) (/year/{year}, /month/{month}): from blog archive widget (?)
- [x] 'rake edit_post' to refresh the 'updated' field of metadata to the current time.

## stretch goals

- [x] try with multiple authors
- [ ] try with many posts
- [ ] dropdown on author-social with more social when it doesn't fit on one line.
- [ ] text search

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
{% endraw %}
