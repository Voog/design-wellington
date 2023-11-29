{% comment %}Body background styles{% endcomment %}
<style>
  .body-bg-color {
    background-color: {{ body_bg_color }};
  }

  .body-bg-image {
    {% if body_bg_image != blank %}background-image: url("{{ body_bg_image }}");{% endif %}
    background-position: center;
    background-size: cover;
  }
</style>
