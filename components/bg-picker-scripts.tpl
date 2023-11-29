<script type="text/javascript">
  $(function() {
    $('.bg-picker-area').each(function(index, pickerArea) {
      var $picker = $(pickerArea).find('.bg-picker');

      if (!$picker.length) {
        return;
      }

      var pickerOpts = $picker.data();

      var bgPicker = new Edicy.BgPicker($picker, {
        picture: pickerOpts.type_picture,
        color: pickerOpts.type_color,
        showAlpha: true,
        target_width: pickerOpts.width,
        preview: function(data) {
          site.bgPickerPreview(
            pickerArea,
            data,
            bgPicker
          );
        },
        commit: function(data) {
          site.bgPickerCommit(
            pickerOpts.bg_key,
            data,
            bgPicker,
            pickerOpts.entity
          );
        }
      });
    });
  })
</script>
