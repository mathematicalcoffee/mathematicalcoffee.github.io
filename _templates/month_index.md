---
layout: default
title: Posts for %{monyear}
permalink: /%{year}/%{month}/
---
<ul>
  {% for post in site.posts %}
    {% assign my=post.date | date: '%B %Y' %}
      {% if my == '%{monyear}' %}
        {% include post-short.html %}
      {% endif %}
  {% endfor %}
</ul>
