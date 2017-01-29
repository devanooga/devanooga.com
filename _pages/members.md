---
layout: page
title: Members
permalink: /members/
menu_group: 1
menu_sort: 3
---

<div>
{% assign members = (site.data.members | sort: "name") %}
{% for member_hash in members %}
    {% assign member = member_hash[1] %}
    <div>
        {{ member.name }}
        <img src="https://s.gravatar.com/avatar/{{ member.gravatar }}?s=160&r=g" alt="{{ member.name }}" />
    </div>
{% endfor %}
</div>