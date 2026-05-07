<%@ page contentType="text/html;charset=UTF-8" %>
<script>
(function () {
  document.querySelectorAll('[data-tp-star-rating]').forEach(function (wrap) {
    var inputId = wrap.getAttribute('data-input-id');
    var input = inputId ? document.getElementById(inputId) : null;
    var stars = wrap.querySelectorAll('.tp-star-hit');

    function paint(value) {
      var v = Math.min(5, Math.max(1, value));
      if (input) {
        input.value = String(v);
      }
      stars.forEach(function (btn, idx) {
        var n = idx + 1;
        var icon = btn.querySelector('i');
        var filled = n <= v;
        btn.classList.toggle('tp-star-empty', !filled);
        btn.setAttribute('aria-pressed', filled ? 'true' : 'false');
        if (icon) {
          icon.className = filled ? 'bi bi-star-fill' : 'bi bi-star';
        }
      });
      wrap.dataset.value = String(v);
    }

    stars.forEach(function (btn) {
      btn.type = 'button';
      btn.addEventListener('click', function () {
        paint(parseInt(btn.getAttribute('data-value'), 10));
      });
    });

    var start = input && input.value ? parseInt(input.value, 10) : parseInt(wrap.dataset.initial || '5', 10);
    paint(isNaN(start) ? 5 : start);
  });
})();
</script>
