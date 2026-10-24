-- Claude Code commands guide: sections. Run AFTER schema.sql. Safe to run again.
delete from public.book_chapters where book_slug = 'claude-code-commands-ta';
insert into public.book_chapters (book_slug, position, title, content, is_sample) values
('claude-code-commands-ta', 1, $vd$முன்பக்கம் (அட்டை, பொருளடக்கம், அறிவிப்பு)$vd$, $vd$![பக்கம் 1](p01)

![பக்கம் 2](p02)

![பக்கம் 3](p03)$vd$, true),
('claude-code-commands-ta', 2, $vd$1. ப்ராஜெக்ட் & மெமரி மேனேஜ்மென்ட்$vd$, $vd$![பக்கம் 4](p04)$vd$, true),
('claude-code-commands-ta', 3, $vd$2. உரையாடல் & காண்டெக்ஸ்ட் கட்டுப்பாடு$vd$, $vd$![பக்கம் 5](p05)

![பக்கம் 6](p06)$vd$, false),
('claude-code-commands-ta', 4, $vd$3–4. மாடல், கோடிங் & ஷிப்பிங்$vd$, $vd$![பக்கம் 7](p07)

![பக்கம் 8](p08)$vd$, false),
('claude-code-commands-ta', 5, $vd$5–6. ஏஜென்ட்ஸ், MCP, பிளக்கின்ஸ் & ஸ்கில்ஸ்$vd$, $vd$![பக்கம் 9](p09)

![பக்கம் 10](p10)$vd$, false),
('claude-code-commands-ta', 6, $vd$7–8. இன்டகிரேஷன்ஸ் & அமைப்புகள்$vd$, $vd$![பக்கம் 11](p11)

![பக்கம் 12](p12)$vd$, false),
('claude-code-commands-ta', 7, $vd$8–9. UI, சிஸ்டம் & அக்கவுண்ட்$vd$, $vd$![பக்கம் 13](p13)

![பக்கம் 14](p14)

![பக்கம் 15](p15)$vd$, false),
('claude-code-commands-ta', 8, $vd$பகுதி 2: சொந்தமாக Custom Slash Commands$vd$, $vd$![பக்கம் 16](p16)

![பக்கம் 17](p17)$vd$, false);
