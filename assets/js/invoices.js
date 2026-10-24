// My invoices: lists the signed-in user's paid orders and shows each GST invoice.
(function () {
  var sb = window.vdSb, msg = document.getElementById('inv-msg'), list = document.getElementById('inv-list');
  var view = document.getElementById('inv-view'), frame = document.getElementById('inv-frame');
  var NAMES = { 'ai-agents-tamil': 'Tamil AI Agents book', 'claude-code-commands-ta': 'Claude Code commands guide (Tamil)' };
  document.getElementById('inv-back').addEventListener('click', function () { view.hidden = true; list.hidden = false; });
  document.getElementById('inv-print').addEventListener('click', function () { frame.contentWindow.focus(); frame.contentWindow.print(); });
  (async function () {
    var s = (await sb.auth.getSession()).data.session;
    if (!s) { location.href = '/login/?next=' + encodeURIComponent('/invoices/'); return; }
    var r = await sb.from('orders').select('book_slug,amount,invoice_no,invoice_date,invoice_html').eq('user_id', s.user.id).eq('status', 'paid').not('invoice_no', 'is', null).order('invoice_date', { ascending: false });
    if (r.error) { msg.textContent = 'Could not load your invoices. Please try again.'; return; }
    if (!r.data.length) { msg.textContent = 'No invoices yet. An invoice appears here right after a purchase.'; return; }
    msg.textContent = 'Signed in as ' + s.user.email + '.';
    r.data.forEach(function (o) {
      var row = document.createElement('div'); row.className = 'inv-item';
      var t = document.createElement('div');
      var d = new Date(o.invoice_date).toLocaleDateString('en-GB', { timeZone: 'Asia/Kolkata' });
      t.textContent = (NAMES[o.book_slug] || o.book_slug) + ' | ' + o.invoice_no + ' | ' + d + ' | \u20B9' + (o.amount / 100).toFixed(2);
      var b = document.createElement('button'); b.type = 'button'; b.className = 'btn btn-primary btn-sm'; b.textContent = 'View invoice';
      b.addEventListener('click', function () { frame.srcdoc = o.invoice_html; list.hidden = true; view.hidden = false; });
      row.appendChild(t); row.appendChild(b); list.appendChild(row);
    });
  })();
})();
