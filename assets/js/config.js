// Public settings only. The anon key and Razorpay Key ID are meant to be public.
// NEVER put the Razorpay Key Secret, webhook secret or Supabase service_role key here.
window.VD_CONFIG = {
  SUPABASE_URL: "https://opmpglxwltsxfmanblzk.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9wbXBnbHh3bHRzeGZtYW5ibHprIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTI4MTM0NzUsImV4cCI6MjEwODM4OTQ3NX0.oaLGgEWqgim-r6i81FSlPhjYf0d4iV6QgfvLFw23sic",
  RAZORPAY_KEY_ID: "rzp_live_Ts3FJzyw4rZmAf",   // live Key ID (public).
  BOOK_SLUG: "ai-agents-tamil",
  BOOK_URL: "/books/ai-agents-tamil/",
  READ_URL: "/read/",
  // Every product sold here. Prices are enforced on the server (create-order function), not from this file.
  BOOKS: {
    "ai-agents-tamil":          { url: "/books/ai-agents-tamil/",          read: "/read/",                          price: 299, label: "Tamil AI Agents book" },
    "claude-code-commands-ta":  { url: "/books/claude-code-commands-tamil/", read: "/read/?b=claude-code-commands-ta", price: 199, label: "Claude Code commands guide (Tamil)" },
    "rea-tamil":                { url: "/books/rea-tamil/", read: "/read/?b=rea-tamil", price: 199, label: "REA: Reverse Engineer Anything (Tamil)" }
  }
};
