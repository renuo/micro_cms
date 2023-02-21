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
        var authorizationToken = element.getAttribute('data-authorization-token');
        window.e = event;

        var data = new FormData();
        data.append('micro_cms_content_block[content]', event.editor.getData());
        data.append('micro_cms_content_block[authorization_token]', authorizationToken);

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
          beforeSend: function() { return true; },
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

  if ('Turbolinks' in window && Turbolinks.supported) {
    $(document).on('turbolinks:load', setupMicroCms);
  } else if ('Turbo' in window) {
    document.addEventListener('turbo:load', setupMicroCms);
  } else {
    window.addEventListener('load', setupMicroCms);
  }
})(jQuery);
