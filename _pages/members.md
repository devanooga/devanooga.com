---
layout: page
title: Members
permalink: /members/
menu_group: 1
menu_sort: 3
---

<div>
{% assign members = (site.members | sort: 'name') %}
{% for member in members %}
    <div>
        {{ member.name }}
        <img src="https://s.gravatar.com/avatar/{{ member.gravatar }}?s=160&r=g" alt="{{ member.name }}" />
    </div>
{% endfor %}
</div>