---
layout: default
title: Posts written by %{author}
permalink: /author/%{handle}/
---
{% assign c=0 %}
{% for post in site.posts %}
  {% if post.authors and post.authors contains '%{key}' %}
    {% assign c=c | plus:1 %}
  {% endif %}
{% endfor %}
{% if c > 0 %}
<p><ul>
  {% for post in site.posts %}
    {% if post.authors and post.authors contains '%{key}' %}
      {% include post-short.html %}
    {% endif %}
  {% endfor %}
</ul></p>
{% else %}
<p>No posts by this author.</p>
{% endif %}
