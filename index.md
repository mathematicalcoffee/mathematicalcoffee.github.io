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

## +1 and like buttons

+1 button (but I can't seem to click it):

<div class="g-plusone" data-size="small" data-annotation="inline" data-width="120" data-href="http://www.example.com"></div>

Like button:

<div class="fb-like" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button_count" data-action="like" data-show-faces="true" data-share="false"></div>

Note: for +1 button to fix not-clicking you need to enable some cookies: http://www.jesse-smith.net/fixed-google-plus-1-button-working/ And I assume likewise for fb.
Maybe leave this out entirely.

## To-Do

- [ ] 'blog' page should not show comments but instead a link with 'x comments'.
- [ ] v. slow compiling (suspect tagcloud)
- [ ] site.title not site.name?
- [ ] google analytics
- [ ] Jekyll 2.0 now supported on gh-pages: use bootstrap-sass rather than css?
- [ ] listing of *all* posts?
- [ ] get custom CSS: http://getbootstrap.com/customize/
- [ ] use modals for popups for social
- [ ] 'like' and +1 per-post links
- [ ] 'follow blog' links: like and +1 (already have rss, atom)
- [ ] sidebar:
    - [x] post archive
    - [x] social
    - [ ] followers
    - [ ] popular posts
    - [x] label cloud
- [ ] RMD compiling
- [ ] fix MS gradients on navbar
- [ ] prettify seach result listings: headings only, or excerpts allowed.
- [x] sort tag-cloud by frequency (and cap the maximum number)
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

Markdown problems: I want

* fenced code blocks with three-backtick style,
* double-space-for-newline (the default), and `hard_wrap` **off** (`hard_wrap` converts newlines in paragraphs to `br`),

Now, **kramdown** does not support three-backtick style unless you turn github-flavoured-markdown on. This turns `hard_wrap` on by default, so I turn that off. However, then a double space is no longer converted to a newline (a bug I believe, [I reported it](https://github.com/gettalong/kramdown/issues/152)). So, cannot use kramdown.

Hence I'm using redcarpet. (Note: oddity with markdown (not nec. redcarpet): comment tag has to be on newline or it gets parsed literally. And you're left with another newline from the tag itself so it can cause unintended paragraphs)).

**Maruku** is deprecated.

**rdiscount** ?

## stretch goals

- [x] try with multiple authors
- [ ] try with many posts
- [ ] dropdown on author-social with more social when it doesn't fit on one line.
- [ ] text search

Comments, BASE_PATH for github:

<http://jekyllbootstrap.com/usage/blog-configuration.html>

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
