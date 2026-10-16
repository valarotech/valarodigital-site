// Valarodigital — site script
(function () {
  document.documentElement.classList.add('js');

  // Google Apps Script web-app URL for the enquiry form.
  // Leave empty until the "Valarodigital Leads" sheet is set up; the form then falls back to WhatsApp.
  var FORM_ENDPOINT = '';
  var SHEET_NAME = 'Valarodigital Leads';
  var WHATSAPP = '917904931067';

  // Mobile menu
  var toggle = document.querySelector('.nav-toggle');
  var nav = document.getElementById('site-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', function () {
      var open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open);
      toggle.setAttribute('aria-label', open ? 'Close menu' : 'Open menu');
    });
    nav.addEventListener('click', function (e) {
      if (e.target.closest('a')) {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  // Reveal on scroll
  var items = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (en.isIntersecting) { en.target.classList.add('visible'); io.unobserve(en.target); }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    items.forEach(function (el) { io.observe(el); });
  } else {
    items.forEach(function (el) { el.classList.add('visible'); });
  }

  // Footer year
  document.querySelectorAll('[data-year]').forEach(function (el) { el.textContent = new Date().getFullYear(); });

  // "Ask about this" buttons pre-select the service in the form
  var select = document.getElementById('service-select');
  document.querySelectorAll('.js-service').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var want = btn.getAttribute('data-service');
      if (!select || !want) return;
      for (var i = 0; i < select.options.length; i++) {
        if (select.options[i].text === want) { select.selectedIndex = i; break; }
      }
    });
  });

  // Enquiry form
  var form = document.getElementById('enquiry-form');
  if (!form) return;
  var status = form.querySelector('.form-status');

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var data = new FormData(form);
    if (data.get('website')) return; // spam trap

    var name = (data.get('name') || '').trim();
    var phone = (data.get('phone') || '').trim();
    if (!name || !phone) {
      status.className = 'form-status err';
      status.textContent = 'Please add your name and phone number.';
      return;
    }

    if (!FORM_ENDPOINT) {
      var text = 'Hi Valarodigital,\n' +
        'Name: ' + name + '\nPhone: ' + phone +
        (data.get('business') ? '\nBusiness: ' + data.get('business') : '') +
        (data.get('city') ? '\nCity: ' + data.get('city') : '') +
        '\nNeed: ' + data.get('service') +
        (data.get('message') ? '\nMessage: ' + data.get('message') : '');
      window.open('https://wa.me/' + WHATSAPP + '?text=' + encodeURIComponent(text), '_blank', 'noopener');
      status.className = 'form-status ok';
      status.textContent = 'Opening WhatsApp with your details…';
      return;
    }

    data.append('sheet', SHEET_NAME);
    data.append('page', location.href);
    status.className = 'form-status';
    status.textContent = 'Sending…';
    fetch(FORM_ENDPOINT, { method: 'POST', mode: 'no-cors', body: new URLSearchParams(data) })
      .then(function () {
        form.reset();
        status.className = 'form-status ok';
        status.textContent = 'Thank you! We will reply within one business day.';
      })
      .catch(function () {
        status.className = 'form-status err';
        status.textContent = 'Could not send. Please message us on WhatsApp.';
      });
  });
})();
