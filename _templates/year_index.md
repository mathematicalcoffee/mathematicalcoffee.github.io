---
layout: default
title: Posts for %{year}
permalink: /%{year}/
---
<ul>
{% for post in site.posts %}
  {% assign y=post.date | date: '%Y' %}
    {% if y == '%{year}' %}
      {% capture currentmonth %}{{post.date | date: '%B'}}{% endcapture %}
      {% if currentmonth != month %}
        {% unless forloop.first %}
  </li></ul>{% endunless %}
  <li><a href="/%{year}/{{ post.date | date: '%m'}}/">{{ currentmonth }}</a>
    <ul>
          {% capture month %}{{currentmonth}}{% endcapture %} 
      {% endif %}
            {% include post-short.html %}
    {% endif %}
{% endfor %}
</ul>
