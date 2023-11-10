{% comment %}Body background styles{% endcomment %}
<style>
  .body-bg-color {
    background-color: {{ body_bg_color }};
  }

  .body-bg-image {
    background-image: url("{{ body_bg_image }}");
    background-position: center;
    background-size: cover;
  }
</style>
