---
layout: default
title: Posts in category "%{category}"
permalink: /category/%{category}/
---
<ul>
  {% for post in site.categories.%{category} %}
    {% include post-short.html %}
  {% endfor %}
</ul>
