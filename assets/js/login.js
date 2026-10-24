(function () {
  var sb = window.vdSb, $ = function (id) { return document.getElementById(id); };
  var next = window.vdSafeNext(new URLSearchParams(location.search).get('next'));
  var email = '', cool = null;
  function msg(t, bad) { var m = $('msg'); m.textContent = t || ''; m.className = 'auth-msg' + (bad ? ' bad' : ''); }
  function busy(b, on) { b.disabled = on; }
  function cooldown() {
    var s = 30, b = $('resend'); b.disabled = true;
    clearInterval(cool);
    cool = setInterval(function () { s--; b.textContent = s > 0 ? 'Resend code in ' + s + 's' : 'Resend code'; if (s <= 0) { clearInterval(cool); b.disabled = false; } }, 1000);
    b.textContent = 'Resend code in 30s';
  }
  async function send() {
    msg('Sending code…');
    var r = await sb.auth.signInWithOtp({ email: email, options: { shouldCreateUser: true } });
    if (r.error) {
      var m = String(r.error.message || ''), st = r.error.status;
      if (st === 429 || /rate|seconds|too many|limit/i.test(m)) msg('A code was requested a moment ago. Please wait one minute, then press the button again. Check your inbox and spam folder for the earlier code.', true);
      else if (/invalid/i.test(m) && /email/i.test(m)) msg('That email address does not look right. Please check it and try again.', true);
      else msg('We could not send the code right now. Please try again in a few minutes, or WhatsApp us on +91 79049 31067.', true);
      if (window.console) console.warn('otp error', st, m);
      return false;
    }
    msg('We sent a 6-digit code to ' + email + '. It can take a minute. Check spam too.');
    return true;
  }
  sb.auth.getSession().then(function (r) { if (r.data.session) location.replace(next); });
  $('f-email').addEventListener('submit', async function (e) {
    e.preventDefault(); email = $('email').value.trim().toLowerCase();
    var b = e.target.querySelector('button'); busy(b, true);
    if (await send()) { $('f-email').hidden = true; $('f-code').hidden = false; $('code').focus(); cooldown(); }
    busy(b, false);
  });
  $('f-code').addEventListener('submit', async function (e) {
    e.preventDefault(); var b = e.target.querySelector('button[type=submit]'); busy(b, true); msg('Checking…');
    var r = await sb.auth.verifyOtp({ email: email, token: $('code').value.trim(), type: 'email' });
    if (r.error) { msg('That code is wrong or has expired. Please try again.', true); busy(b, false); return; }
    location.replace(next);
  });
  $('resend').addEventListener('click', async function () { if (await send()) cooldown(); });
  $('change').addEventListener('click', function () { $('f-code').hidden = true; $('f-email').hidden = false; msg(''); });
})();
