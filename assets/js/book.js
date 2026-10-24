// Book page: Buy now / Read now button
(function () {
  var C = window.VD_CONFIG, sb = window.vdSb, btn = document.getElementById('buy-btn');
  var note = document.getElementById('buy-note'), label = btn.querySelector('.lbl');
  function say(t, bad) { note.textContent = t; note.style.color = bad ? '#ffb4a2' : ''; }
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
      if (await window.vdHasBook(uid)) { location.href = C.READ_URL; return; }
      await new Promise(function (r) { setTimeout(r, 2000); });
    }
    say('Your payment went through, but the book has not unlocked yet. Please wait a minute and refresh, or WhatsApp us on +91 79049 31067.', true);
    btn.disabled = false;
  }
  async function buy(session) {
    btn.disabled = true; say('Starting payment…');
    try {
      var res = await fetch(C.SUPABASE_URL + '/functions/v1/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + session.access_token, 'apikey': C.SUPABASE_ANON_KEY },
        body: JSON.stringify({ book_slug: C.BOOK_SLUG })
      });
      var d = await res.json();
      if (d.already) { location.href = C.READ_URL; return; }
      if (!res.ok || !d.order_id) throw new Error(d.error || 'order');
      await loadRzp();
      var rz = new window.Razorpay({
        key: d.key_id, amount: d.amount, currency: 'INR', order_id: d.order_id,
        name: 'Valarodigital', description: 'Tamil AI Agents book (online access)',
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
    if (session && await window.vdHasBook(session.user.id)) {
      label.textContent = 'Read now'; btn.href = C.READ_URL; btn.onclick = null;
      say('You own this book. Signed in as ' + session.user.email + '.'); return;
    }
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      if (!session) { location.href = '/login/?next=' + encodeURIComponent(C.BOOK_URL + '?buy=1'); return; }
      buy(session);
    });
    if (session) { say('Signed in as ' + session.user.email + '.'); if (/[?&]buy=1/.test(location.search)) buy(session); }
  }
  init();
})();
