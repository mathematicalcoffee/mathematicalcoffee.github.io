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

- [ ] disqus comments
- [ ] sidebar:
    - [ ] post archive
    - [ ] popular posts
- [ ] RMD compiling
- [ ] Colours from Awesome.inc
- [x] navbar dropdown styling: make sure collapsing it undoes the styling
- [ ] fix MS gradients on navbar
- [ ] sidebar styling
- [ ] style buttons

Comments, BASE_PATH for github:

http://jekyllbootstrap.com/usage/blog-configuration.html
