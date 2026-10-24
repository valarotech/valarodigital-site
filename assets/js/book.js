// Book page: Buy now / Read now button
(function () {
  var C = window.VD_CONFIG, sb = window.vdSb, btn = document.getElementById('buy-btn');
  var SLUG = btn.getAttribute('data-book') || C.BOOK_SLUG, B = C.BOOKS[SLUG];
  var note = document.getElementById('buy-note'), label = btn.querySelector('.lbl');
  function say(t, bad) { note.textContent = t; note.style.color = bad ? '#ffb4a2' : ''; }
  var STATES = ["Andaman and Nicobar Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli and Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Ladakh","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  // Billing details for the GST invoice: name, state, pincode.
  function askDetails() {
    return new Promise(function (resolve) {
      var ov = document.createElement('div'); ov.className = 'bill-ov';
      var f = document.createElement('form'); f.className = 'bill-box';
      function h(tag, txt, cls) { var e = document.createElement(tag); if (txt) e.textContent = txt; if (cls) e.className = cls; return e; }
      f.appendChild(h('h3', 'Billing details'));
      f.appendChild(h('p', 'These go on your GST invoice. We email the invoice to ' + (window.__vdEmail || 'your email') + '.', 'bill-sub'));
      var l1 = h('label', 'Full name'), name = document.createElement('input');
      name.type = 'text'; name.required = true; name.maxLength = 100; name.autocomplete = 'name'; l1.appendChild(name); f.appendChild(l1);
      var l2 = h('label', 'State'), st = document.createElement('select'); st.required = true;
      var o0 = document.createElement('option'); o0.value = ''; o0.textContent = 'Select state'; st.appendChild(o0);
      STATES.forEach(function (x) { var o = document.createElement('option'); o.value = x; o.textContent = x; st.appendChild(o); });
      l2.appendChild(st); f.appendChild(l2);
      var l3 = h('label', 'Pincode'), pin = document.createElement('input');
      pin.type = 'text'; pin.required = true; pin.inputMode = 'numeric'; pin.maxLength = 6; pin.pattern = '[1-9][0-9]{5}'; pin.autocomplete = 'postal-code'; l3.appendChild(pin); f.appendChild(l3);
      var l4 = h('label', 'Address (optional)'), addr = document.createElement('textarea');
      addr.rows = 2; addr.maxLength = 300; addr.autocomplete = 'street-address'; l4.appendChild(addr); f.appendChild(l4);
      var row = h('div', '', 'bill-row'), go = h('button', 'Continue to payment', 'btn btn-primary'), no = h('button', 'Cancel', 'btn btn-ghost');
      go.type = 'submit'; no.type = 'button'; row.appendChild(go); row.appendChild(no); f.appendChild(row);
      ov.appendChild(f); document.body.appendChild(ov); name.focus();
      function close(v) { document.body.removeChild(ov); resolve(v); }
      no.addEventListener('click', function () { close(null); });
      f.addEventListener('submit', function (e) {
        e.preventDefault();
        if (name.value.trim().length < 2 || !st.value || !/^[1-9][0-9]{5}$/.test(pin.value.trim())) { pin.reportValidity(); return; }
        close({ name: name.value.trim(), state: st.value, pin: pin.value.trim(), address: addr.value.trim() });
      });
    });
  }
  function loadRzp() {
    return new Promise(function (ok, no) {
      if (window.Razorpay) return ok();
      var s = document.createElement('script'); s.src = 'https://checkout.razorpay.com/v1/checkout.js';
      s.onload = ok; s.onerror = no; document.head.appendChild(s);
    });
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
    window.__vdEmail = session.user.email;
    var det = await askDetails();
    if (!det) { say(''); return; }
    btn.disabled = true; say('Starting payment…');
    try {
      var res = await fetch(C.SUPABASE_URL + '/functions/v1/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + session.access_token, 'apikey': C.SUPABASE_ANON_KEY },
        body: JSON.stringify({ book_slug: SLUG, customer_name: det.name, customer_state: det.state, customer_pincode: det.pin, customer_address: det.address })
      });
      var d = await res.json();
      if (d.already) { location.href = B.read; return; }
      if (!res.ok || !d.order_id) throw new Error(d.error || 'order');
      await loadRzp();
      var rz = new window.Razorpay({
        key: d.key_id, amount: d.amount, currency: 'INR', order_id: d.order_id,
        name: 'Valarodigital', description: B.label + ' (online access)',
        prefill: { email: session.user.email }, theme: { color: '#ff6a2b' },
        handler: function () { waitForAccess(session.user.id); },
        modal: { ondismiss: function () { btn.disabled = false; say(''); } }
      });
      rz.on('payment.failed', function () { btn.disabled = false; say('Payment failed. No access was given. You can try again.', true); });
      rz.open(); say('');
    } catch (e) { btn.disabled = false; say('Could not start the payment. Please try again.', true); }
  }
  async function init() {
    var r = await sb.auth.getSession(), session = r.data.session;
    if (session && await window.vdHasBook(session.user.id, SLUG)) {
      label.textContent = 'Read now'; btn.href = B.read; btn.onclick = null;
      say('You own this book. Signed in as ' + session.user.email + '.'); return;
    }
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      if (!session) { location.href = '/login/?next=' + encodeURIComponent(B.url + '?buy=1'); return; }
      buy(session);
    });
    if (session) { say('Signed in as ' + session.user.email + '.'); if (/[?&]buy=1/.test(location.search)) buy(session); }
  }
  init();
})();
