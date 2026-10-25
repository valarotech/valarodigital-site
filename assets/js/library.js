// My books: shows what the signed-in user has bought (with a Read button and invoice link) and the books they have not bought yet.
(function () {
  var sb = window.vdSb, msg = document.getElementById('lib-msg');
  var mine = document.getElementById('lib-mine'), more = document.getElementById('lib-more');
  var ADMIN_EMAIL = 'valaroenterprises@gmail.com';
  function fmt(d) { return new Date(d).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric', timeZone: 'Asia/Kolkata' }); }
  (async function () {
    var s = (await sb.auth.getSession()).data.session;
    if (!s) { location.replace('/login/?next=' + encodeURIComponent('/library/')); return; }
    var isAdmin = (s.user.email || '').toLowerCase() === ADMIN_EMAIL;
    var ent = await sb.from('entitlements').select('book_slug,created_at').eq('user_id', s.user.id);
    var ord = await sb.from('orders').select('book_slug,created_at,invoice_date,invoice_no').eq('user_id', s.user.id).eq('status', 'paid').order('created_at', { ascending: false });
    if (ent.error) { msg.textContent = 'Could not load your books. Please refresh and try again.'; return; }
    var owned = {};
    (ent.data || []).forEach(function (e) { owned[e.book_slug] = { date: e.created_at }; });
    (ord.data || []).forEach(function (o) { if (owned[o.book_slug]) { owned[o.book_slug].date = o.invoice_date || o.created_at; owned[o.book_slug].inv = o.invoice_no; } });
    var rows = document.querySelectorAll('#lib-src .book-row'), nOwn = 0;
    rows.forEach(function (row) {
      var slug = row.getAttribute('data-slug'), own = owned[slug] || (isAdmin ? {} : null);
      var buy = row.querySelector('.book-row-buy');
      if (own) {
        nOwn++;
        buy.textContent = '';
        var st = document.createElement('span'); st.className = 'lib-status';
        st.textContent = own.date ? 'Purchased on ' + fmt(own.date) : 'Owner access';
        var a = document.createElement('a'); a.className = 'btn btn-primary'; a.href = row.getAttribute('data-read'); a.textContent = 'Read now';
        buy.appendChild(st); buy.appendChild(a);
        if (own.inv) { var iv = document.createElement('a'); iv.className = 'btn btn-ghost'; iv.href = '/invoices/'; iv.textContent = 'Invoice ' + own.inv; buy.appendChild(iv); }
        var chips = row.querySelector('.chips'); if (chips) chips.remove();
        mine.appendChild(row);
      } else { more.appendChild(row); }
    });
    msg.textContent = nOwn ? (nOwn + (nOwn === 1 ? ' book' : ' books') + ' in your library. Signed in as ' + s.user.email + '.') : 'You have not bought a book yet. Pick one below.';
    if (more.children.length) document.getElementById('lib-more-h').hidden = false;
    if (nOwn && !isAdmin) document.getElementById('lib-links').hidden = false;
  })();
})();
