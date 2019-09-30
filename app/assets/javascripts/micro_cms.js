(function($) {
  CKEDITOR.disableAutoInline = true;

  var setupMicroCms = function() {
    for (var instance in CKEDITOR.instances) {
      if (!CKEDITOR.instances.hasOwnProperty(instance)) {
        break;
      }

      CKEDITOR.instances[instance].on('blur', function(event) {
        event.editor.updateElement();
        var element = event.editor.element.$;
        var updateUrl = element.getAttribute('data-update-url');
        window.e = event;

        var data = new FormData();
        data.append('micro_cms_content_block[content]', event.editor.getData());

        function blink(className) {
          $(element).addClass(className);
          setTimeout(function () {
            $(element).removeClass(className);
          }, 1000);
        }

        Rails.ajax({
          type: 'PATCH',
          url: updateUrl,
          dataType: 'json',
          contentType: 'multipart/form-data',
          data: data,
          success: function(e) {
            blink('successful');
          },
          error: function(e) {
            console.error(e);
            blink('error');
          },
        })
      });
    }
  };

  window.addEventListener('load', setupMicroCms);

  if ('Turbolinks' in window && Turbolinks.supported) {
    $(document).on('turbolinks:load', setupMicroCms);
  }
})(jQuery);
