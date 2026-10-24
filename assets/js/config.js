// Public settings only. The anon key and Razorpay Key ID are meant to be public.
// NEVER put the Razorpay Key Secret, webhook secret or Supabase service_role key here.
window.VD_CONFIG = {
  SUPABASE_URL: "https://opmpglxwltsxfmanblzk.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9wbXBnbHh3bHRzeGZtYW5ibHprIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTI4MTM0NzUsImV4cCI6MjEwODM4OTQ3NX0.oaLGgEWqgim-r6i81FSlPhjYf0d4iV6QgfvLFw23sic",
  RAZORPAY_KEY_ID: "rzp_test_TrcZIpoxfHLMJK",   // test key. Replace with the live Key ID at go-live.
  BOOK_SLUG: "ai-agents-tamil",
  BOOK_URL: "/books/ai-agents-tamil/",
  READ_URL: "/read/"
};
