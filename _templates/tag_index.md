---
layout: default
title: Posts tagged "%{tag}"
permalink: /tag/%{tag}/
---
<ul>
  {% for post in site.tags.%{tag} %}
    {% include post-short.html %}
  {% endfor %}
</ul>
