---
layout: default
title: Hello World!
tagline: Supporting tagline
---

doop-di-doop-di-doo.

Here's a sample "posts list".

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

## To-Do

- [ ] remove obscene amounts of whitespace between tags https://github.com/penibelst/jekyll-compress-html
- [ ] use maxcdn or use my own? cdn seems slow but maybe that's my internet
- [ ] get custom CSS: http://getbootstrap.com/customize/
- [ ] category vs tag
- [ ] use modals for popups for social bar
- [ ] search by tag/category
- [ ] blog listing is a generic template, use to display search results
- [ ] use same code for post layout in post page and blog listing page.
- [x] post footer: likes, poster, ...
- [x] disqus comments
- [ ] sidebar:
    - [ ] post archive
    - [ ] popular posts
- [ ] RMD compiling
- [x] fix up headings
- [x] Colours from Awesome.inc
- [x] navbar dropdown styling: make sure collapsing it undoes the styling
- [ ] fix MS gradients on navbar
- [ ] sidebar styling
- [x] hosted by github/powered by jekyll/designed with bootstrap/copyright me footer

Comments, BASE_PATH for github:

http://jekyllbootstrap.com/usage/blog-configuration.html
