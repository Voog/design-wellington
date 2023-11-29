<!DOCTYPE html>
{%- include "template-settings" -%}
{%- include "template-variables" -%}
<html class="{% if editmode %}editmode{% else %}publicmode{% endif %}" lang="{{ page.language_code }}">
  <head prefix="og: http://ogp.me/ns#">
    {%- include "html-head" -%}
    {%- include "template-styles" -%}
  </head>
  <body class="bg-picker-area body-bg-picker-area js-background-type {{ body_bg_type }}">
    <div class="body-bg-image js-background-image"></div>
    <div class="body-bg-color js-background-color"></div>

    {%- if editmode %}
      <button
        class="voog-bg-picker-btn body-bg-picker bg-picker"
        data-bg_key="{{ body_bg_key }}"
        data-type_picture="true"
        data-type_color="true"
        data-color_elem=".body-bg-color"
        data-picker_area_elem=".body-bg-picker-area"
        data-picker_elem=".body-bg-picker"
        data-bg-image="{{ body_bg_image }}"
        data-bg-color="{{ body_bg_color }}"
        data-bg-image-sizes="{{ body_bg_image_sizes_str | escape }}"
      ></button>
    {% endif -%}

    <div class="container-wrap">
      {% include "header" %}

      <div class="container">
        <main class="content" role="main" data-search-indexing-allowed="true">
          <div class="content-formatted">
            {% content %}
          </div>
        </main>
      </div>
    </div>

    {%- include "javascripts" -%}
  </body>
</html>
