// Shared Supabase client + small helpers (loaded after supabase-js and config.js)
(function () {
  var C = window.VD_CONFIG;
  window.vdSb = window.supabase.createClient(C.SUPABASE_URL, C.SUPABASE_ANON_KEY, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: false }
  });
  // Only allow same-site relative paths after login (stops open redirects).
  window.vdSafeNext = function (n) {
    return (typeof n === 'string' && n.charAt(0) === '/' && n.charAt(1) !== '/' && n.indexOf('\\') < 0) ? n : C.BOOK_URL;
  };
  // The shop owner (admin) can read every book. The database enforces this too (admin policies), so this only changes what the page shows.
  var ADMIN_EMAIL = 'valaroenterprises@gmail.com';
  window.vdHasBook = async function (userId, slug) {
    try {
      var ss = await window.vdSb.auth.getSession();
      var em = ss.data && ss.data.session && ss.data.session.user && ss.data.session.user.email;
      if (em && em.toLowerCase() === ADMIN_EMAIL) return true;
    } catch (e) {}
    var r = await window.vdSb.from('entitlements').select('book_slug').eq('book_slug', slug || C.BOOK_SLUG).eq('user_id', userId).limit(1);
    return !r.error && r.data && r.data.length > 0;
  };
})();
