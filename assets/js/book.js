(function () {
  var C = window.VD_CONFIG, sb = window.vdSb, btn = document.getElementById('buy-btn');
  var SLUG = btn.getAttribute('data-book') || C.BOOK_SLUG, B = C.BOOKS[SLUG];
  var note = document.getElementById('buy-note'), label = btn.querySelector('.lbl');
  function say(t, bad) { note.textContent = t; note.style.color = bad ? '#ffb4a2' : ''; }
  var STATES = ["Andaman and Nicobar Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli and Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Ladakh","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  var EMAIL_RE = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
  function normMobile(v) { return v.replace(/[\s-]/g, '').replace(/^(\+91|91|0)(?=[6-9][0-9]{9}$)/, ''); }
  // Billing details form (name, email, mobile, state, pincode, optional address).
  function askDetails(session) {
    return new Promise(function (resolve) {
      var ov = document.createElement('div'); ov.className = 'bill-ov';
      var f = document.createElement('form'); f.className = 'bill-box'; f.noValidate = true;
      function h(tag, txt, cls) { var e = document.createElement(tag); if (txt) e.textContent = txt; if (cls) e.className = cls; return e; }
      function field(lbl, el) { var l = h('label', lbl); l.appendChild(el); f.appendChild(l); return el; }
      function inp(type, extra) { var e = document.createElement('input'); e.type = type; Object.keys(extra || {}).forEach(function (k) { e[k] = extra[k]; }); return e; }
      f.appendChild(h('h3', 'Billing details'));
      f.appendChild(h('p', 'These go on your GST invoice.', 'bill-sub'));
      var name = field('Full name', inp('text', { maxLength: 100, autocomplete: 'name' }));
      var email = field('Email', inp('email', { maxLength: 200, autocomplete: 'email', inputMode: 'email' }));
      var enote = h('p', '', 'bill-sub bill-email-note'); f.appendChild(enote);
      function showNote() {
        var v = email.value.trim();
        enote.textContent = v ? 'Your invoice and a link to your books will be sent to: ' + v + '. Please check that it is correct.' : 'Your invoice and a link to your books will be sent to the email you enter here.';
      }
      email.addEventListener('input', showNote);
      var email2 = null;
      if (session) { email.value = session.user.email; email.readOnly = true; }
      else {
        email2 = field('Confirm email', inp('email', { maxLength: 200, autocomplete: 'off', inputMode: 'email' }));
        email2.addEventListener('paste', function (e) { e.preventDefault(); });
      }
      showNote();
      var mob = field('Mobile number', inp('tel', { maxLength: 14, autocomplete: 'tel', inputMode: 'numeric' }));
      var st = document.createElement('select'); var o0 = document.createElement('option'); o0.value = ''; o0.textContent = 'Select state'; st.appendChild(o0);
      STATES.forEach(function (x) { var o = document.createElement('option'); o.value = x; o.textContent = x; st.appendChild(o); });
      field('State', st);
      var pin = field('Pincode', inp('text', { maxLength: 6, autocomplete: 'postal-code', inputMode: 'numeric' }));
      var addr = document.createElement('textarea'); addr.rows = 2; addr.maxLength = 300; addr.autocomplete = 'street-address'; field('Address (optional)', addr);
      var err = h('p', '', 'bill-err'); err.setAttribute('role', 'alert'); f.appendChild(err);
      var row = h('div', '', 'bill-row'), go = h('button', 'Pay now', 'btn btn-primary'), no = h('button', 'Cancel', 'btn btn-ghost');
      go.type = 'submit'; no.type = 'button'; row.appendChild(go); row.appendChild(no); f.appendChild(row);
      ov.appendChild(f); document.body.appendChild(ov); name.focus();
      function close(v) { document.body.removeChild(ov); resolve(v); }
      no.addEventListener('click', function () { close(null); });
      f.addEventListener('submit', function (e) {
        e.preventDefault();
        var em = email.value.trim().toLowerCase(), msg = '';
        if (name.value.trim().length < 2) msg = 'Please enter your full name.';
        else if (!EMAIL_RE.test(em)) msg = 'Please enter a valid email.';
        else if (email2 && email2.value.trim().toLowerCase() !== em) msg = 'The two email entries do not match.';
        else if (!/^[6-9][0-9]{9}$/.test(normMobile(mob.value))) msg = 'Please enter a valid 10-digit mobile number.';
        else if (!st.value) msg = 'Please select your state.';
        else if (!/^[1-9][0-9]{5}$/.test(pin.value.trim())) msg = 'Please enter a valid 6-digit pincode.';
        if (msg) { err.textContent = msg; return; }
        close({ name: name.value.trim(), email: em, mobile: mob.value.trim(), state: st.value, pin: pin.value.trim(), address: addr.value.trim() });
      });
    });
  }

  // Simple message box with a button that opens My books. No login code is sent from here:
  // the buyer signs in later from My books, and the code is sent at that moment.
  function infoBox(title, text) {
    var ov = document.createElement('div'); ov.className = 'bill-ov';
    var f = document.createElement('div'); f.className = 'bill-box';
    function h(tag, txt, cls) { var e = document.createElement(tag); if (txt) e.textContent = txt; if (cls) e.className = cls; return e; }
    f.appendChild(h('h3', title));
    f.appendChild(h('p', text, 'bill-sub'));
    var row = h('div', '', 'bill-row'), go = h('a', 'Open My books', 'btn btn-primary'), cl = h('button', 'Close', 'btn btn-ghost');
    go.href = '/library/'; cl.type = 'button';
    cl.addEventListener('click', function () { document.body.removeChild(ov); });
    row.appendChild(go); row.appendChild(cl); f.appendChild(row);
    ov.appendChild(f); document.body.appendChild(ov);
  }

  var rzpPromise = null;
  function loadRzp() {
    if (rzpPromise) return rzpPromise;
    rzpPromise = new Promise(function (ok, no) {
      if (window.Razorpay) return ok();
      var s = document.createElement('script'); s.src = 'https://checkout.razorpay.com/v1/checkout.js';
      s.onload = ok; s.onerror = function () { rzpPromise = null; no(); }; document.head.appendChild(s);
    });
    return rzpPromise;
  }
  async function waitForAccess(uid) {
    say('Payment received. Unlocking your book…');
    for (var i = 0; i < 20; i++) {
      if (await window.vdHasBook(uid, SLUG)) { location.href = B.read; return; }
      await new Promise(function (r) { setTimeout(r, 2000); });
    }
    say('Your payment went through, but the book has not unlocked yet. Please wait a minute and refresh, or WhatsApp us on +91 79049 31067.', true);
    btn.disabled = false;
  }
  async function buy(session) {
    var det = await askDetails(session);
    if (!det) { say(''); return; }
    btn.disabled = true; say('Starting payment…');
    var rzpReady = loadRzp().catch(function () {}); // load Razorpay while the order is being created
    try {
      var headers = { 'Content-Type': 'application/json', 'apikey': C.SUPABASE_ANON_KEY, 'Authorization': 'Bearer ' + (session ? session.access_token : C.SUPABASE_ANON_KEY) };
      var res = await fetch(C.SUPABASE_URL + '/functions/v1/create-order', {
        method: 'POST', headers: headers,
        body: JSON.stringify({ book_slug: SLUG, customer_name: det.name, customer_email: det.email, customer_state: det.state, customer_pincode: det.pin, customer_address: det.address, customer_mobile: det.mobile })
      });
      var d = await res.json();
      if (d.already) {
        if (session) { location.href = B.read; return; }
        btn.disabled = false; say('');
        infoBox('You already own this', 'This email (' + det.email + ') already has this book. Open My books and sign in with this email to read it. We send the login code at that time.'); return;
      }
      if (!res.ok || !d.order_id) throw new Error(d.error || 'order');
      await rzpReady; await loadRzp();
      var rz = new window.Razorpay({
        key: d.key_id, amount: d.amount, currency: 'INR', order_id: d.order_id,
        name: 'Valarodigital', description: B.label + ' (online access)',
        prefill: { email: det.email, contact: det.mobile, name: det.name }, theme: { color: '#ff6a2b' },
        handler: function () {
          if (session) { waitForAccess(session.user.id); return; }
          btn.disabled = false; say('Payment received. Thank you!');
          infoBox('Payment received', 'Thank you! We are emailing your tax invoice and a link to My books to ' + det.email + '. To read, open My books and sign in with this email. We will send you a login code at that time. Check spam if the email is late.');
        },
        modal: { ondismiss: function () { btn.disabled = false; say(''); } }
      });
      rz.on('payment.failed', function () { btn.disabled = false; say('Payment failed. No money was taken for access. Please press Buy and try again.', true); });
      rz.open(); say('');
    } catch (e) { btn.disabled = false; say('Could not start the payment. Please check your details and try again.', true); }
  }
  async function init() {
    loadRzp().catch(function () {}); // preload so the payment window opens faster
    var r = await sb.auth.getSession(), session = r.data.session;
    if (session && await window.vdHasBook(session.user.id, SLUG)) {
      label.textContent = 'Read now'; btn.href = B.read; btn.onclick = null;
      say('You own this book. Signed in as ' + session.user.email + '.'); return;
    }
    btn.addEventListener('click', function (e) { e.preventDefault(); buy(session); });
    if (session) { say('Signed in as ' + session.user.email + '.'); if (/[?&]buy=1/.test(location.search)) buy(session); }
  }
  init();
})();
