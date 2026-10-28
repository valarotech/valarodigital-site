// Valarodigital — site script
(function () {
  document.documentElement.classList.add('js');

  // Where the Free Business Consultation form is sent (Supabase edge function "submit-lead").
  var LEAD_ENDPOINT = 'https://opmpglxwltsxfmanblzk.supabase.co/functions/v1/submit-lead';

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

  // Free Business Consultation form. The server checks everything again; these checks only give quick, friendly feedback.
  var form = document.getElementById('enquiry-form');
  if (!form) return;
  var status = form.querySelector('.form-status');
  var button = form.querySelector('button[type="submit"]');
  var FIELDS = ['name', 'mobile', 'email', 'service', 'details', 'consent'];
  var busy = false;

  function setErr(field, msg) {
    var el = document.getElementById('e-' + field);
    var input = form.elements[field];
    if (el) el.textContent = msg || '';
    if (input) { if (msg) input.setAttribute('aria-invalid', 'true'); else input.removeAttribute('aria-invalid'); }
  }
  function check(v) {
    var e = {};
    var name = v.name.replace(/\s+/g, ' ').trim();
    if (name.length < 2 || name.length > 100 || !/^[\p{L}\p{M}][\p{L}\p{M} .'\u2019-]*$/u.test(name)) e.name = 'Please enter your name (letters only).';
    var mobile = v.mobile.replace(/[\s-]/g, '').replace(/^(\+91|91|0)(?=[6-9][0-9]{9}$)/, '');
    if (!/^[6-9][0-9]{9}$/.test(mobile)) e.mobile = 'Please enter a valid 10-digit mobile number.';
    var email = v.email.trim();
    if (email.length > 254 || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) e.email = 'Please enter a valid email address.';
    if (!v.service) e.service = 'Please choose a service.';
    if (v.details.length > 1000) e.details = 'Please keep your note under 1000 characters.';
    if (!v.consent) e.consent = 'Please tick the box so we can contact you.';
    return e;
  }
  function say(cls, msg) { status.className = 'form-status' + (cls ? ' ' + cls : ''); status.textContent = msg; }

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    if (busy) return;
    var f = form.elements;
    if (f.website.value) return; // spam trap: real visitors never see this field
    var v = { name: f.name.value, mobile: f.mobile.value, email: f.email.value, service: f.service.value, details: f.details.value, consent: f.consent.checked };
    var errs = check(v);
    FIELDS.forEach(function (k) { setErr(k, errs[k]); });
    var first = FIELDS.filter(function (k) { return errs[k]; })[0];
    if (first) { say('err', 'Please fix the highlighted fields.'); f[first].focus(); return; }

    busy = true; button.disabled = true; say('', 'Sending\u2026');
    fetch(LEAD_ENDPOINT, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: v.name, mobile: v.mobile, email: v.email, service: v.service, details: v.details, consent: true,
        website: f.website.value, t: Math.round(performance.now()), page: location.pathname })
    }).then(function (r) { return r.json().catch(function () { return {}; }).then(function (j) { return { status: r.status, body: j }; }); })
      .then(function (res) {
        if (res.body && res.body.ok) {
          form.reset();
          FIELDS.forEach(function (k) { setErr(k, ''); });
          say('ok', 'Thank you! We have received your request and will contact you within one business day.');
        } else if (res.status === 422 && res.body.errors) {
          FIELDS.forEach(function (k) { setErr(k, res.body.errors[k]); });
          say('err', 'Please fix the highlighted fields.');
        } else if (res.status === 429) {
          say('err', 'We already have your request or are very busy. Please WhatsApp us on +91 79049 31067.');
        } else { throw new Error('bad'); }
      })
      .catch(function () { say('err', 'Sorry, we could not send this. Please WhatsApp us on +91 79049 31067 or email hello@valarodigital.com.'); })
      .then(function () { busy = false; button.disabled = false; });
  });
})();
