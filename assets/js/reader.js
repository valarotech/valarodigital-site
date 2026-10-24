// Online reader. Content comes from Supabase and is only returned to people who bought the book (Row Level Security).
(function () {
  var C = window.VD_CONFIG, sb = window.vdSb, $ = function (id) { return document.getElementById(id); };
  var qs = new URLSearchParams(location.search).get('b');
  var SLUG = (qs && C.BOOKS[qs]) ? qs : C.BOOK_SLUG, B = C.BOOKS[SLUG];
  var chapters = [], cur = 0, owned = false, email = '';

  // ---- deterrents (they raise the effort; they cannot stop a phone camera) ----
  var stop = function (e) { e.preventDefault(); return false; };
  ['contextmenu', 'copy', 'cut', 'dragstart', 'selectstart'].forEach(function (t) { document.addEventListener(t, stop); });
  document.addEventListener('keydown', function (e) {
    var k = (e.key || '').toLowerCase();
    if (e.key === 'PrintScreen' || e.key === 'F12' || ((e.ctrlKey || e.metaKey) && ['c', 'x', 'a', 'p', 's', 'u'].indexOf(k) > -1) ||
        ((e.ctrlKey || e.metaKey) && e.shiftKey && ['i', 'j', 'c', 's', '3', '4', '5'].indexOf(k) > -1)) {
      e.preventDefault();
      if (e.key === 'PrintScreen') { try { navigator.clipboard.writeText(' '); } catch (x) {} hide(true); setTimeout(function () { hide(false); }, 1500); }
    }
  });
  function hide(on) { document.body.classList.toggle('rd-hidden', on); }
  document.addEventListener('visibilitychange', function () { hide(document.hidden); });
  window.addEventListener('blur', function () { hide(true); });
  window.addEventListener('focus', function () { hide(false); });
  window.addEventListener('beforeprint', function () { hide(true); });

  function watermark(text) {
    var t = text.replace(/&/g, '&amp;').replace(/</g, '&lt;');
    var svg = '<svg xmlns="http://www.w3.org/2000/svg" width="360" height="200"><text x="20" y="110" transform="rotate(-24 180 100)" font-family="Arial" font-size="15" fill="rgba(11,21,48,0.10)">' + t + '</text></svg>';
    $('wm').style.backgroundImage = 'url("data:image/svg+xml,' + encodeURIComponent(svg) + '")';
  }
  // Content is plain text: blank line = new paragraph, "## " = heading, "- " = bullet. Set with textContent, so no HTML is ever injected.
  function render(ch) {
    var box = $('page'); box.textContent = '';
    var h = document.createElement('h1'); h.textContent = ch.title; box.appendChild(h);
    String(ch.content || '').split(/\n{2,}/).forEach(function (blk) {
      blk = blk.trim(); if (!blk) return;
      var el;
      var im = /^!\[([^\]]*)\]\(([a-z0-9_-]+)\)$/.exec(blk);
      if (im) { el = document.createElement('img'); el.alt = im[1]; el.draggable = false; el.setAttribute('data-name', im[2]); }
      else if (blk.indexOf('### ') === 0) { el = document.createElement('h3'); el.textContent = blk.slice(4); }
      else if (blk.indexOf('## ') === 0) { el = document.createElement('h2'); el.textContent = blk.slice(3); }
      else if (blk.indexOf('- ') === 0) { el = document.createElement('ul'); blk.split('\n').forEach(function (l) { var li = document.createElement('li'); li.textContent = l.replace(/^-\s*/, ''); el.appendChild(li); }); }
      else { el = document.createElement('p'); el.textContent = blk; }
      box.appendChild(el);
    });
    loadImages(box);
    $('prev').disabled = cur === 0; $('next').disabled = cur === chapters.length - 1;
    $('pos').textContent = (cur + 1) + ' / ' + chapters.length;
    Array.prototype.forEach.call($('toc').children, function (li, i) { li.firstChild.className = i === cur ? 'on' : ''; });
    window.scrollTo(0, 0);
    if (!owned && ch.is_sample === false) {}
  }
  var imgCache = {};
  async function loadImages(box) {
    var els = box.querySelectorAll('img[data-name]'); if (!els.length) return;
    var need = [];
    els.forEach(function (el) { var n = el.getAttribute('data-name'); if (imgCache[n]) el.src = imgCache[n]; else need.push(n); });
    if (!need.length) return;
    var q = await sb.from('book_images').select('name,data').eq('book_slug', SLUG).in('name', need);
    (q.data || []).forEach(function (r) { imgCache[r.name] = r.data; });
    els.forEach(function (el) { var d = imgCache[el.getAttribute('data-name')]; if (d) el.src = d; });
  }
  function go(i) { cur = Math.max(0, Math.min(chapters.length - 1, i)); render(chapters[cur]); $('sidebar').classList.remove('open'); }

  async function init() {
    var r = await sb.auth.getSession();
    if (!r.data.session) { location.replace('/login/?next=' + encodeURIComponent(B.read)); return; }
    email = r.data.session.user.email; watermark(email + ' · Valarodigital');
    $('who').textContent = email;
    owned = await window.vdHasBook(r.data.session.user.id, SLUG);
    var q = await sb.from('book_chapters').select('position,title,content,is_sample').eq('book_slug', SLUG).order('position');
    if (q.error || !q.data.length) { $('page').textContent = 'Could not load the book. Please refresh or contact us.'; return; }
    chapters = q.data;
    chapters.forEach(function (ch, i) {
      var li = document.createElement('li'), b = document.createElement('button');
      b.type = 'button'; b.textContent = ch.title + (ch.is_sample && !owned ? '  (free sample)' : ''); b.addEventListener('click', function () { go(i); });
      li.appendChild(b); $('toc').appendChild(li);
    });
    if (!owned) { $('lockbuy').href = B.url + '?buy=1'; $('lockbuy').textContent = 'Buy full access \u20b9' + B.price + ' + tax'; $('lock').hidden = false; }
    go(0);
  }
  $('prev').addEventListener('click', function () { go(cur - 1); });
  $('next').addEventListener('click', function () { go(cur + 1); });
  $('menu').addEventListener('click', function () { $('sidebar').classList.toggle('open'); });
  $('out').addEventListener('click', async function () { await sb.auth.signOut(); location.href = B.url; });
  init();
})();
