-- Book text. Run AFTER schema.sql. Safe to run again (it replaces the chapters).
delete from public.book_chapters where book_slug = 'ai-agents-tamil';
insert into public.book_chapters (book_slug, position, title, content, is_sample) values
('ai-agents-tamil', 1, $vd$இந்தப் புத்தகத்தைப் பற்றி$vd$, $vd$செயற்கை நுண்ணறிவு (Artificial Intelligence – AI) கருவிகளை வெறும் கேள்வி–பதில் உதவியாளராக மட்டும் பயன்படுத்தாமல், ஒரு முழு வேலையை ஒப்படைத்து முடித்து வாங்கும் Agent-ஆகப் பயன்படுத்துவது எப்படி என்பதை இந்தப் புத்தகம் எளிய தமிழில் விளக்குகிறது.

இந்தப் புத்தகம் எதைக் கற்றுத் தருகிறது?

Claude போன்ற பெரிய மொழி மாதிரி (Large Language Model – LLM) அடிப்படையிலான கருவிகளில் Agent என்றால் என்ன, ஒரு வேலையை எப்படி வரையறுத்து ஒப்படைப்பது, Agent-ஐ எப்படி வடிவமைப்பது, பாதுகாப்பு விதிகளை எப்படி அமைப்பது, வேலைகளை எப்படித் தானியங்கியாக்குவது, முதல் Agent-ஐ எப்படி உருவாக்குவது என்பதை இந்தப் புத்தகம் கற்றுத் தருகிறது.

யார் படிக்கலாம்?

- AI கருவிகளைப் புதிதாகக் கற்கும் தொடக்கநிலை வாசகர்கள், மாணவர்கள், பெற்றோர்
- தங்கள் தினசரி வேலைகளை எளிதாக்க விரும்பும் தொழில்முறை நபர்கள்
- Software developer மற்றும் architect பார்வையில் Agent வடிவமைப்பைப் புரிந்துகொள்ள விரும்புவோர்

இதில் நீங்கள் கற்றுக்கொள்ளப் போவது

- Agent, Sub-agent, Orchestrator போன்ற சொற்களின் எளிய பொருள்
- வேலையை Scope, Steps, Guardrails, Report-back என்ற வடிவத்தில் ஒப்படைக்கும் முறை
- Name, Soul, Job, Keys, Stop Condition என்ற 5 பகுதிகளில் Agent-ஐ வடிவமைக்கும் முறை
- Slash Commands, Hooks, Routines, Webhooks, Git Worktrees ஆகியவற்றின் பயன்பாடு
- ஒரு Agent file-ஐ எழுதி, சோதித்து, மேம்படுத்தும் முறை

முன் அனுபவம் தேவையா?

ஆழ்ந்த தொழில்நுட்ப அனுபவம் அவசியமில்லை. ஒரு folder மற்றும் file-ஐ உருவாக்கும் அடிப்படை கணினி அறிவு இருந்தால் போதும். Software architecture அனுபவம் இருந்தால் சில ஒப்பீடுகள் இன்னும் எளிதாகப் புரியும்.

அத்தியாயங்கள் எப்படி அமைந்துள்ளன?

புத்தகம் நான்கு பகுதிகளாகவும் 13 அத்தியாயங்களாகவும் பிரிக்கப்பட்டுள்ளது: Agent அடிப்படைகள், Agent Architecture, Automation மற்றும் Scheduling, முதல் Agent உருவாக்கம். இறுதியில் பின்னிணைப்பு, சொற்களஞ்சியம், மேற்கோள்கள் உள்ளன.$vd$, true),
('ai-agents-tamil', 2, $vd$முன்னுரை$vd$, $vd$AI கருவிகள் வேகமாக வளர்ந்து வருகின்றன. ஆனால் பலர் அவற்றை இன்னும் ஒரு கேள்விக்கு ஒரு பதில் தரும் chat-ஆகவே பயன்படுத்துகிறார்கள். ஒரு முழு வேலையை ஒப்படைத்து, அது தானாகப் பல படிகளில் செயல்பட்டு, முடிவை நம்மிடம் திருப்பிக் கொண்டு வரும் Agent முறை இன்னும் பலருக்குப் புதிது.

இந்தப் புத்தகத்தின் நோக்கம், அந்த முறையை எளிய தமிழில், ஆங்கிலத் தொழில்நுட்பச் சொற்களை அப்படியே பயன்படுத்தி, படிப்படியாக விளக்குவதாகும். வேகமாக வேலை செய்யும் AI-ஐ நம்மால் எளிதாகச் சரிபார்த்து ஒப்புக்கொள்ளக்கூடிய ஒரு அமைப்பாக மாற்றுவதே இதன் மையக் கருத்து.

இந்தப் புத்தகத்தின் ஆசிரியர் P.Karthikeyan தற்போது Architect-ஆகப் பணியாற்றுகிறார்; தகவல் தொழில்நுட்பத் துறையில் 17+ ஆண்டுகள் அனுபவம் உடையவர்.

P.Karthikeyan$vd$, true),
('ai-agents-tamil', 3, $vd$இந்தப் புத்தகத்தை எப்படிப் பயன்படுத்துவது$vd$, $vd$இந்தப் புத்தகத்தைப் பயனுள்ள வகையில் படிக்க சில வழிகள்:

- நீங்கள் தொடக்கநிலை வாசகர் என்றால் அத்தியாயங்களை வரிசையாகப் படியுங்கள்.
- ஒவ்வொரு அத்தியாயத்தின் முடிவிலும் உள்ள “நீங்கள் கற்றுக்கொண்டவை” பகுதியை மீள்பார்வைக்குப் பயன்படுத்துங்கள்.
- “சிந்தித்துப் பார்க்க / செய்து பார்க்க” பகுதியில் உள்ள கேள்விகளையும் பயிற்சிகளையும் உங்கள் சொந்த வேலையுடன் இணைத்து முயற்சி செய்யுங்கள்.
- புதிய சொற்கள் வரும்போது புத்தகத்தின் இறுதியில் உள்ள சொற்களஞ்சியத்தைப் பாருங்கள்.
- AI கருவிகள் வேகமாக மாறுவதால், கட்டளைகள், கோப்புப் பாதைகள், வசதிகள் ஆகியவற்றை செயல்படுத்தும் முன் அதிகாரப்பூர்வ ஆவணங்களில் சரிபாருங்கள்.$vd$, true),
('ai-agents-tamil', 4, $vd$அத்தியாயம் 1: முதல்ல, Agent-ன்னா என்ன?$vd$, $vd$இந்த அத்தியாயம் Agent என்பதன் எளிய வரையறையையும், சாதாரண Claude பயன்பாட்டுக்கும் Agent பயன்பாட்டுக்கும் உள்ள வேறுபாட்டையும், Sub-agent என்ற யோசனையையும் அறிமுகப்படுத்துகிறது.

கற்றல் நோக்கங்கள்

- Agent என்பதற்கு ஒரு எளிய வரையறையைச் சொல்ல முடியும்.
- சாதாரண Claude பயன்பாட்டுக்கும் Agent பயன்பாட்டுக்கும் உள்ள வேறுபாட்டை விளக்க முடியும்.
- Manager என்ற பார்வையில் உங்கள் பங்கை அடையாளம் காண முடியும்.

simplest definition:

ஒரு Agent-க்கு Goal, அதை அடைய தேவையான Tools, multiple steps எடுக்க Permission கொடுத்தா, அது தானாக அந்த steps-ஐ செய்து result கொண்டு வரும்.

Normal Claude usage:

நீங்க கேட்கிறீங்க → Claude answer பண்ணும் → அடுத்தது நீங்க கேட்கிறீங்க → Claude answer பண்ணும்

Agent usage:

நீங்க ஒரு complete வேலை கொடுக்கிறீங்க → Agent பல steps-ஆ தானாக வேலை செய்கிறது → final result உங்ககிட்ட கொண்டு வருகிறது.

இதைத்தான் course “go handle this and come back” mode என்று சொல்கிறது.

## Sub-agent என்றால்?

Main Agent ஒரு specific வேலையைச் செய்ய, அதற்குள்ளேயே இன்னொரு helper Claude-ஐ பயன்படுத்தலாம்.

Example:

![நீங்கள் இயக்குநராக இருந்து Research, Clean up, Draft, Deploy Agents-ஐ வழிநடத்துவதைக் காட்டும் விளக்கப்படம்](image1)

Main Agent

↓

Research sub-agent

↓

Result

Screenshot சொல்லும் முக்கிய mindset:

நீங்க worker இல்லை. Manager.

Manager-ஆ உங்க வேலை:

Scope → Hand off → Check result

நீங்கள் கற்றுக்கொண்டவை

- Agent = Goal + Tools + Permission + பல படிகள் (Multiple steps).
- சாதாரண பயன்பாட்டில் கேள்வி–பதில் நடக்கும்; Agent பயன்பாட்டில் முழு வேலை ஒப்படைக்கப்படும்.
- உங்கள் பங்கு: Scope → Hand off → Check result.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் தினசரி வேலைகளில் எந்த ஒரு வேலையை Agent-இடம் ஒப்படைக்கலாம்?
- அந்த வேலைக்கான Goal, Tools, Permission ஆகியவற்றை எழுதிப் பாருங்கள்.$vd$, true),
('ai-agents-tamil', 5, $vd$அத்தியாயம் 2: வேலையை ஒப்படைக்கும் முறை: Scope மற்றும் Brief$vd$, $vd$தெளிவில்லாத வேலையை Agent-இடம் கொடுத்தால் அது நிறைய விஷயங்களை ஊகிக்க வேண்டியிருக்கும். இந்த அத்தியாயம் நல்ல Agent Brief-ன் நான்கு பகுதிகளையும், முதல் multi-step வேலையை எப்படி ஒப்படைப்பது என்பதையும் விளக்குகிறது.

கற்றல் நோக்கங்கள்

- Weak instruction-க்கும் Scoped instruction-க்கும் உள்ள வேறுபாட்டைச் சொல்ல முடியும்.
- Scope, Steps, Guardrails, Report-back என்ற நான்கு பகுதிகளைப் பயன்படுத்த முடியும்.
- “Review, not redo” என்ற விதியைப் புரிந்துகொள்ள முடியும்.

## “Scoping a Job” ஏன் ரொம்ப முக்கியம்?

![வேலையை Scope செய்யும் ஐந்து பகுதிகள்: Goal, Inputs, Outputs, Stop-condition, Escalation](image2)

Agent-கிட்ட vague-ஆ வேலை கொடுத்தா, அது நிறைய விஷயங்களை guess பண்ண வேண்டியிருக்கும்.

### ❌ Weak instruction

“Clean up my notes folder.”

இதுல Agent-க்கு நிறைய doubt:

- எந்த folder?
- எப்படி clean பண்ணணும்?
- எதை delete பண்ணலாம்?
- எப்போது வேலை முடிந்ததாக எடுத்துக்கொள்ளணும்?

### ✅ நல்ல Scoped instruction

Screenshot example-ன் meaning:

/notes folder-ல இருக்கிற ஒவ்வொரு file-ஐயும் பாரு. Content based on ஒரு clear title கொடு. Obvious typo இருந்தா fix பண்ணு. மேலே one-line summary சேர். எதையும் delete பண்ணாதே. வேலையை ஆரம்பிப்பதற்கு முன் plan காட்டணும். எல்லாம் முடிந்த பிறகு என்ன என்ன மாற்றினாய் என்று list கொடு, நான் review பண்ணுகிறேன்.

இப்ப Agent guess பண்ண வேண்டியது மிகவும் குறையும்.

## நல்ல Agent Brief-க்கு தேவையான 4 விஷயங்கள்

Screenshot இதை ரொம்ப முக்கியமா சொல்கிறது.

### ① Exact Scope

எங்கே வேலை செய்யணும்?

உதாரணம்:

/notes folder மட்டும்.

அதைத் தாண்டி வேறு folder touch பண்ணக்கூடாது.

### ② Steps

என்ன order-ல என்ன செய்யணும்?

உதாரணம்:

- Files படி
- Title check பண்ணு
- Typo fix பண்ணு
- Summary add பண்ணு
- Changes list கொடு

### ③ Guardrails

என்ன செய்யக்கூடாது?

உதாரணம்:

- Delete பண்ணக்கூடாது
- வெளியே send பண்ணக்கூடாது
- Approval இல்லாமல் finalise பண்ணக்கூடாது

இது மிகவும் important.

### ④ Report-back

வேலை முடிந்ததும்:

“Exactly என்ன மாற்றினாய் என்று சொல்லு.”

அப்போதான் நீங்க review பண்ண முடியும்.

இதைத்தான் இந்த course Scoping என்று சொல்கிறது.

## First Real Multi-Step Task எப்படி Hand-off பண்ணுவது?

![Task brief கொடுத்தல், Agent வேலை செய்தல், Result திரும்ப வருதல் என்ற Scoped hand-off ஓட்டம்](image3)

Screenshot-ல நல்ல workflow கொடுத்திருக்காங்க:

Scoped hand-off → Work → Result back

முதல்ல ஒரு real task எடுத்துக்கணும். Perfect task தேட வேண்டியதில்லை.

Agent-க்கு வேலை கொடுத்து, முதல் தடவை அது எப்படி வேலை செய்கிறது என்று watch பண்ணுங்கள்.

முக்கியமான safety point:

“Show me the plan first, then go.”

அதாவது Agent என்ன செய்யப் போகிறது என்பதை முதலில் புரிந்துகொண்டு, பிறகு execute செய்ய வைக்கிறோம்.

## இந்த course சொல்ற முக்கிய rule: நீங்க “Review” பண்ணணும்

ஒரு line எனக்கு இதில் ரொம்ப முக்கியமா தெரிகிறது:

Your job the whole time is review, not redo.

அதாவது Agent வேலை செய்த பிறகு, நீங்க அந்த entire வேலையை மறுபடியும் செய்யக்கூடாது.

நீங்க செய்ய வேண்டியது:

Agent என்ன change செய்தது? → சரியா? → approve செய்யலாமா?

இதுதான் human + agent working model.

நீங்கள் கற்றுக்கொண்டவை

- நல்ல Brief = Scope + Steps + Guardrails + Report-back.
- வேலையைத் தொடங்கும் முன் plan காட்டச் சொல்வது பாதுகாப்பானது.
- Agent வேலை செய்த பிறகு நீங்கள் செய்ய வேண்டியது review; மீண்டும் முழு வேலையை நீங்களே செய்வதல்ல.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- “Clean up my notes folder” என்ற வாக்கியத்தை நான்கு பகுதிகளுடன் மீண்டும் எழுதிப் பாருங்கள்.
- உங்கள் வேலையில் ஒரு Report-back வாக்கியத்தை எழுதுங்கள்.$vd$, false),
('ai-agents-tamil', 6, $vd$அத்தியாயம் 3: Agent பயன்பாட்டில் தவிர்க்க வேண்டிய தவறுகள்$vd$, $vd$தொடக்கநிலையில் பெரும்பாலானவர்கள் செய்யும் நான்கு தவறுகளை இந்த அத்தியாயம் எடுத்துக்காட்டுகளுடன் காட்டுகிறது.

கற்றல் நோக்கங்கள்

- நான்கு பொதுவான தவறுகளை அடையாளம் காண முடியும்.
- Tight by default என்ற கொள்கையை விளக்க முடியும்.
- Automation-க்கு முன் test run ஏன் தேவை என்பதைச் சொல்ல முடியும்.

## Beginners செய்யுற common mistakes

![Beginners செய்யும் தவறுகள்: Vague goals, No stop condition, Too many tools, No test run](image4)

Screenshot இதை மிகவும் clear-ஆ சொல்கிறது.

### ❌ Mistake 1: Vague Goal

“Sort out my emails.”

இது மிகவும் vague.

எந்த emails?

எப்படி sort?

என்ன செய்யலாம்?

என்ன செய்யக்கூடாது?

Agent உங்க intention-ஐ guess பண்ண வேண்டியிருக்கும்.

### ❌ Mistake 2: Stop Condition இல்லாமல் விடுவது

Agent எப்போது நிறுத்தணும் என்பது தெரியணும்.

உதாரணம்:

எல்லா unread emails-யும் categorize பண்ணியதும், required drafts save ஆனதும் stop.

Stop condition இல்லையென்றால் Agent-க்கு “done” என்ற definition clear-ஆ இருக்காது.

### ❌ Mistake 3: அதிகமான Tools கொடுப்பது

Agent-க்கு தேவையில்லாத permissions/tools எல்லாம் கொடுக்க வேண்டாம்.

உதாரணத்துக்கு ஒரு Agent email read + draft மட்டும் பண்ணணும்னா, அதற்குத் தேவையான access மட்டும் கொடுப்பது safer.

Course-ன் principle:

Tight by default, loosened on purpose.

அதாவது:

முதலில் குறைந்த permission கொடு. தேவையானால் மட்டும் பிறகு expand பண்ணு.

### ❌ Mistake 4: First test பண்ணாம automation போடுவது

இது மிகவும் முக்கியம்.

Wrong approach:

Build Agent → Immediately schedule automation ❌

Better approach:

Build Agent

↓

ஒரு தடவை நீங்க பார்த்துக்கொண்டிருக்கும்போது run பண்ணு

↓

Result check பண்ணு

↓

Trust build பண்ணு

↓

பிறகு automate பண்ணு ✅

ஒரு தவறான process-ஐ automate பண்ணிட்டா, அந்தத் தவறும் automatic-ஆ repeat ஆகும்.

நீங்கள் கற்றுக்கொண்டவை

- Vague goal, Stop condition இல்லாமை, அதிக Tools, First test இல்லாமை ஆகியவை முக்கிய தவறுகள்.
- முதலில் குறைந்த permission; தேவையானால் மட்டும் விரிவுபடுத்தலாம்.
- தவறான process-ஐ automate செய்தால் தவறும் தானாகவே திரும்பத் திரும்ப நடக்கும்.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் ஒரு வேலைக்கான Stop condition-ஐ அளவிடக்கூடிய வகையில் எழுதுங்கள்.
- உங்கள் Agent-க்கு உண்மையில் தேவைப்படும் Tools எவை?$vd$, false),
('ai-agents-tamil', 7, $vd$அத்தியாயம் 4: Agent வடிவமைப்பு: 5-Part Recipe$vd$, $vd$ஒவ்வொரு நல்ல Agent-க்கும் Name, Soul, Job, Keys, Stop Condition என்ற ஐந்து பகுதிகள் இருக்க வேண்டும். இந்த அத்தியாயம் ஒவ்வொன்றையும் ஒரு inbox-triage எடுத்துக்காட்டுடன் விளக்குகிறது.

கற்றல் நோக்கங்கள்

- 5-Part Agent Recipe-ன் ஒவ்வொரு பகுதியையும் விளக்க முடியும்.
- ஒரு Agent-க்கு Job-ஐ ஒரு வாக்கியத்தில் எழுத முடியும்.
- Request–Response மற்றும் Agent செயல்பாட்டை architect பார்வையில் ஒப்பிட முடியும்.

## முக்கியமான “5-Part Agent Recipe”

![5-Part Agent Recipe: Name, Soul, Job, Keys, Stop Condition](image5)

இந்த screenshots-ல இதுதான் core concept.

ஒவ்வொரு நல்ல Agent-க்கும் இந்த 5 விஷயங்கள் இருக்கணும்:

### 1 NAME

Agent-க்கு ஒரு short name.

Examples screenshot-ல:

- inbox-triage
- code-review-buddy
- daily-draft

Short-ஆ, easy-ஆ type பண்ணுற மாதிரி இருக்கணும்.

### 2 SOUL

இது Agent-ன் personality / behaviour / working style.

Agent எப்படி behave பண்ணணும்?

Example:

Calm executive assistant. என்னுடைய attention-ஐ protect பண்ணணும். தேவையில்லாத விஷயங்களுக்கு reply எழுதக்கூடாது.

இதுதான் Agent-க்கு ஒரு consistent working behaviour கொடுக்கும்.

### 3 JOB

Agent-ன் ஒரே முக்கிய mission.

ஒரு sentence-ல எழுத முடியணும்.

Course-ன் idea:

Job-ஐ ஒரு sentence-ல சொல்ல முடியலனா, scope ரொம்ப பெரியதாக இருக்க வாய்ப்பு இருக்கிறது.

Example:

கடந்த 24 மணி நேர unread emails-ஐ review பண்ணி URGENT / RESPOND / FYI / IGNORE என்று classify செய்து, URGENT அல்லது RESPOND emails-க்கு மட்டும் 2-line draft உருவாக்கு.

அது ஒரு clear job.

### 4 KEYS

Agent என்னென்ன resources/tools access பண்ணலாம்?

உதாரணம்:

- எந்த folders read பண்ணலாம்?
- File write பண்ணலாமா?
- Terminal commands run பண்ணலாமா?
- Internet access இருக்கலாமா?

இதைத்தான் screenshot seatbelt மாதிரி describe பண்ணுகிறது.

அதாவது Agent-க்கு:

தேவையான அளவு access மட்டும்.

### 5 STOP CONDITION

இதுதான்:

“வேலை முடிஞ்சிடுச்சுன்னு Agent எப்படி தெரிந்துகொள்ளும்?”

Example:

எல்லா relevant emails-ம் labelled, drafts save செய்யப்பட்டதும் stop.

அதற்கு பிறகு Agent continue பண்ணக்கூடாது.

Stop condition ideally measurable-ஆ இருக்கணும்.

## Screenshot-ல இருக்கும் inbox-triage example

இதைக் கொஞ்சம் easy Tamil-ல மாற்றினா:

### Name

inbox-triage

### Soul

நீ ஒரு calm, strict executive assistant. என் attention-ஐ protect பண்ணணும். தேவையில்லாத email-க்கு reply draft create பண்ணாதே.

### Job

கடந்த 24 மணி நேர unread emails அனைத்தையும் URGENT / RESPOND / FYI / IGNORE என்று categorize பண்ணு. URGENT அல்லது RESPOND emails-க்கு மட்டும் 2-line reply draft உருவாக்கு.

### Keys

Gmail-ஐ read பண்ணலாம். /drafts/inbox-triage/ folder-ல் drafts write பண்ணலாம். Email send பண்ணக்கூடாது. Delete பண்ணக்கூடாது.

### Stop Condition

எல்லா emails-யும் accounted for ஆகி, தேவையான drafts save ஆனதும் நிறுத்து. அதன் summary-ஐ என்னிடம் கொடு.

இந்த example-ஐ பார்த்தால் Agent design philosophy ரொம்ப clear:

Agent-க்கு power கொடுக்கிறோம், ஆனால் unlimited power கொடுக்கவில்லை.

## எல்லா screenshots-யும் சேர்த்து ஒரு Formula

இதை மட்டும் நினைவில் வச்சுக்கிட்டாலே இந்த முழு lesson புரிஞ்ச மாதிரி:

### Agent Definition

Goal + Tools + Permission + Multiple Steps = Agent

### Good Task Delegation

Scope + Steps + Guardrails + Report-back

### Agent Design

Name + Soul + Job + Keys + Stop Condition

### Safe Adoption

Build → Watch → Review → Trust → Automate

## Architect point of view-ல பார்த்தா...

உங்களுக்கு இது familiar pattern-ஆ இருக்கும்.

Normal Claude chat-ஐ ஒரு API call மாதிரி நினைச்சுக்கோங்க:

Request → Response

Agent-ஐ ஒரு long-running worker/service மாதிரி நினைச்சுக்கலாம்:

Goal → Plan → Multiple actions → Validation → Result

அதனால் powerful Agent build பண்ணுறது பெரிய prompt எழுதுவதில் மட்டும் இல்லை.

முக்கியமானது:

Boundary எங்கே? Permission என்ன? Success criteria என்ன? எப்போது stop பண்ணணும்? Human approval எங்கே வரணும்?

இந்த 5 screenshots-லிருந்து நான் எடுத்துக்கொள்ளச் சொல்ற #1 lesson இதுதான்:

“Agent-க்கு எப்படி வேலை செய்யணும் என்று ஒவ்வொரு click-ஆ சொல்லாதீங்க. என்ன result வேண்டும், எங்கே வேலை செய்யலாம், எதை செய்யக்கூடாது, எப்போது நிறுத்த வேண்டும் என்பதை crystal clear-ஆ சொல்லுங்க.”

அதுதான் நல்ல delegation.

நீங்கள் கற்றுக்கொண்டவை

- Name, Soul, Job, Keys, Stop Condition ஆகிய ஐந்தும் ஒரு Agent-ன் அடிப்படை.
- JOB = என்ன செய்ய வேண்டும்; SOUL = எந்த style-ல் செய்ய வேண்டும்.
- Agent-க்கு power கொடுக்கிறோம்; ஆனால் unlimited power அல்ல.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்களுக்குத் தேவையான ஒரு Agent-க்கு ஐந்து பகுதிகளையும் எழுதிப் பாருங்கள்.
- அந்த Agent-ன் Keys-ல் எதை அனுமதிக்க மாட்டீர்கள்?$vd$, false),
('ai-agents-tamil', 8, $vd$அத்தியாயம் 5: Agent Architecture: பல Agents எப்போது தேவை?$vd$, $vd$ஒரே Agent-ஆல் வேலை நடக்கும்போது அதைப் பிரிக்க வேண்டாம். ஆனால் சில வேலைகளுக்கு வெவ்வேறு specialists தேவைப்படும். இந்த அத்தியாயம் Orchestrator, Sub-agent, Agent Team ஆகியவற்றையும், எப்போது பிரிப்பது என்பதையும் விளக்குகிறது.

கற்றல் நோக்கங்கள்

- Orchestrator மற்றும் Sub-agents-ன் பணிகளைச் சொல்ல முடியும்.
- ஒரு Job-ஐ பிரிக்க வேண்டிய மூன்று சூழல்களை அடையாளம் காண முடியும்.
- Sub-agent மற்றும் Agent Team வேறுபாட்டை விளக்க முடியும்.

![Orchestrator மற்றும் Researcher, Drafter, Critic sub-agents காட்டும் வரைபடம்](image6)

## Orchestrator + Sub-Agents

முதலில் ஒரு முக்கியமான rule:

ஒரே Agent-ஆல வேலை சரியாக நடக்கிறதுன்னா, அதை unnecessary-ஆ பல Agents-ஆ split பண்ண வேண்டாம்.

ஆனா சில வேலைகளுக்கு different specialisations தேவைப்படும்.

உதாரணம்:

Research → Draft → Review

இங்கே ஒரே Agent மூன்றையும் செய்தால் ஒரு problem வரலாம்.

- Research செய்யும்போது thorough-ஆ இருக்கணும்
- Draft எழுதும்போது concise / creative-ஆ இருக்கணும்
- Review செய்யும்போது strict / critical-ஆ இருக்கணும்

ஒரே personality-க்கு இந்த மூன்றையும் mix பண்ணினால் quality பாதிக்கலாம்.

அதனால:

You

↓

Orchestrator

├── Researcher

├── Drafter

└── Critic

### Orchestrator என்ன செய்யும்?

Orchestrator actual work செய்ய வேண்டியதில்லை.

Orchestrator-ன் வேலை:

Request புரிந்துகொள் → எந்த specialist தேவை என்று decide பண்ணு → அதற்கு மட்டும் தேவையான context கொடு → result வாங்கு → next specialist-க்கு கொடு → final result உங்களுக்கு கொடு

இதைக் company example-ல பார்த்தா:

நீங்க = Business Owner

Orchestrator = Project Manager

Sub-agents = Specialist Engineers

இதுதான் easiest mental model.

## எப்போது ஒரு Job-ஐ Agents-ஆ Split பண்ணணும்?

Screenshot 3 situations சொல்கிறது.

### Case 1: வேலைக்கு clearly different specialists தேவை

உதாரணம்:

Research → Draft → Review

மூன்றுமே different thinking modes.

அப்ப split useful.

### Case 2: Too much temporary context

200 files படிச்சு ஒரு small answer கண்டுபிடிக்கணும்னு வைத்துக்கோங்க.

Main Agent எல்லா 200 files context-யும் வைத்திருந்தால் conversation clutter ஆகலாம்.

Instead:

Sub-agent → 200 files படிக்கும் → relevant information மட்டும் Main Agent-க்கு கொடுக்கும்

அதுக்குப்பிறகு அந்த temporary research context தேவையில்லை.

இதனால main context clean-ஆ இருக்கும்.

### Case 3: ஒரு component replaceable-ஆ இருக்கணும்

இன்று ஒரு Writer Agent use பண்றீங்க.

நாளைக்கு:

Brand A writer → Brand B writer

மாற்ற வேண்டியிருக்கு.

Modular-ஆ Agents இருந்தால் அந்த component மட்டும் மாற்றலாம்.

மொத்த workflow-யும் rebuild பண்ண வேண்டாம்.

## முக்கிய Warning: Over-engineer பண்ணாதீங்க

Course ரொம்ப practical-ஆ ஒரு விஷயம் சொல்கிறது:

One Agent first. அது break ஆகும் இடம் தெரிந்த பிறகுதான் split பண்ணுங்க.

அதாவது ஆரம்பத்திலேயே:

Agent 1

Agent 2

Agent 3

Agent 4

Agent 5

Agent 6

என்று architecture கட்ட வேண்டாம்.

முதல்ல:

ONE AGENT

↓

Does it work?

↓

Where exactly does it struggle?

↓

Split that responsibility

இது software architecture-க்கும் ரொம்ப familiar principle.

Premature decomposition avoid பண்ணு.

Screenshot இன்னொரு important rule சொல்கிறது:

Sub-agents ஒருத்தரோட ஒருத்தர் direct-ஆ பேசிக்கொள்ள விடாதீங்க.

Instead:

Sub-agent A

↓

Orchestrator

↓

Sub-agent B

அப்போதான் flow predictable-ஆ இருக்கும்.

## Sub-Agent vs Agent Team

இந்த difference மிகவும் important.

### Sub-Agent

Sub-agent temporary.

ஒரு specific task வந்ததும் Main Agent அதை create/use பண்ணும்.

Task முடிந்ததும் அந்த worker-ன் வேலை basically முடிஞ்சது.

Example:

“இந்த 200 files-ல pricing reference எங்கெல்லாம் இருக்குன்னு கண்டுபிடி.”

ஒரு temporary researcher இதை செய்யலாம்.

### Agent Team

Agent Team permanent/reusable structure மாதிரி.

ஒவ்வொரு specialist-க்கும்:

- தனி identity
- தனி Job
- தனி Soul
- தனி tools/access
- தனி Stop Condition

இருக்கும்.

Simple analogy:

Sub-agent = ஒரு வேலைக்காக hire பண்ணுற contractor.

Agent team = தொடர்ந்து உங்களோட வேலை செய்யுற staff/team.

## TeamCreate என்ன?

Screenshot படி TeamCreate என்பது session-க்குள் ஒரு team-ஐ spin up செய்யும் shortcut concept. [ஆசிரியர் சரிபார்க்க வேண்டும்]

ஆனா course சொல்லும் warning முக்கியம்:

### ❌ Beginner mistake

“Agents cool-ஆ இருக்கு. 5-agent team create பண்ணிடலாம்!”

அப்படிச் செய்யக்கூடாது.

முதலில் ஒரு specialist தனியா நல்லா வேலை செய்கிறதா பாருங்க.

பிறகு:

Run several times → stable result → split/team

மற்றொரு mistake:

Agents ஒருத்தரோட ஒருத்தர் uncontrolled-ஆ communication பண்ணுவது.

அது loop / confusion generate பண்ணலாம்.

அதனால் coordination ideally:

Specialists → Orchestrator → Specialists

நீங்கள் கற்றுக்கொண்டவை

- முதலில் ஒரு Agent; அது எங்கே சிரமப்படுகிறது என்று தெரிந்த பிறகே பிரிக்கவும்.
- Sub-agents ஒன்றோடொன்று நேரடியாகப் பேசாமல் Orchestrator வழியாக ஒருங்கிணைக்கப்பட வேண்டும்.
- Sub-agent = தற்காலிக contractor; Agent team = தொடர்ந்து பணிபுரியும் குழு.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் ஒரு வேலையில் Research, Draft, Review என்ற மூன்று நிலைகள் உள்ளனவா?
- அந்த வேலையை இப்போதே பிரிப்பது அவசியமா, அல்லது ஒரு Agent போதுமா?$vd$, false),
('ai-agents-tamil', 9, $vd$அத்தியாயம் 6: Sub-Agent Patterns: நான்கு மறுபயன்பாட்டு முறைகள்$vd$, $vd$நான்கு பொதுவான Sub-agent patterns-ஐ இந்த அத்தியாயம் அறிமுகப்படுத்துகிறது: Code-Review, Explore-Then-Act, Parallel, Simplifier.

கற்றல் நோக்கங்கள்

- நான்கு patterns-ன் நோக்கத்தைச் சொல்ல முடியும்.
- சூழலுக்கு ஏற்ற pattern-ஐ தேர்ந்தெடுக்க முடியும்.
- Fresh-context reviewer ஏன் பயனுள்ளது என்பதை விளக்க முடியும்.

## Four Sub-Agent Patterns

இந்த screenshots-ல எனக்கு மிகவும் useful-ஆ தெரிந்த section இதுதான்.

நான்கு reusable patterns கொடுக்கப்பட்டிருக்கு.

### Pattern 1: Code-Review Subagent

Purpose:

Code/file-ஐ fresh eyes-ல review செய்து problems மட்டும் சொல்லணும்.

முக்கியமானது:

Reviewer rewrite செய்யக்கூடாது.

ஏன்?

Main Agent code எழுதியிருக்கு.

அதே Main Agent review பண்ணினால்:

“நாம எழுதினது சரிதானே”

என்ற bias வரலாம்.

Fresh-context reviewer:

- bugs
- edge cases
- unclear naming
- suspicious code

மாதிரியானவற்றை கண்டுபிடிக்கும்.

Output:

Notes only. Rewrite வேண்டாம்.

Architect/software work-க்கு இது ரொம்ப useful pattern.

### Pattern 2: Explore-Then-Act

இது “முதல்ல தேடு, பிறகு செய்” pattern.

Example:

ஒரு பெரிய codebase இருக்கு:

“இந்த pricing logic எங்கெல்லாம் reference ஆகுது?”

Sub-agent:

Search → Relevant locations கண்டுபிடி → Summary கொடு

Main Agent:

Summary அடிப்படையில் action எடு.

இதன் advantage:

Main conversation-க்கு தேவையில்லாத நூற்றுக்கணக்கான file contents வராது.

### Pattern 3: Parallel Subagents

ஒரே வேலை பல items-க்கு independently செய்ய வேண்டியிருந்தால் parallel use பண்ணலாம்.

உதாரணம் screenshot-ல்:

5 landing pages review பண்ணணும்.

Agent 1 → Page 1

Agent 2 → Page 2

Agent 3 → Page 3

Agent 4 → Page 4

Agent 5 → Page 5

அனைவருக்கும் same rubric.

பிறகு results combine.

இது sequential:

Page 1 → Page 2 → Page 3 →...

என்பதை விட independent வேலைக்கு நல்ல pattern.

### Pattern 4: Simplifier

இது எனக்கு personally நல்ல pattern-ஆ தெரிகிறது.

ஒரு பெரிய output வந்திருக்கு.

Maybe:

- 800-line plan
- Long document
- Verbose draft

Simplifier Agent-க்கு:

“இதில meaning lose ஆகாமல் shortest useful version கொடு.”

முக்கியமான rule:

Simplifier unnecessary explanation கொடுக்காமல் result மட்டும் return பண்ண வேண்டும்.

### இந்த 4 Patterns எப்படி நினைவில் வைக்கிறது?

Course ஒரு simple mental test கொடுக்கிறது.

“நான் இப்ப ஏதாவது எழுதினேனா?”

→ Code Review

“Answer சொல்லும் முன் நிறைய files/data படிக்க வேண்டுமா?”

→ Explore-Then-Act

“இதே வேலையை நிறைய items-க்கு repeat செய்யப் போறேனா?”

→ Parallel

“Output ரொம்ப பெருசா இருக்கு; என்ன cut பண்ணுறது தெரியலையா?”

→ Simplifier

இத மட்டும் நினைவில் வைச்சாலே போதும்.

நீங்கள் கற்றுக்கொண்டவை

- Code-Review: குறைகளை மட்டும் சொல்லும்; மீண்டும் எழுதாது.
- Explore-Then-Act: முதலில் தேடு, பிறகு செயல்படு.
- Parallel: சுயாதீனமான வேலைகளுக்கு; Simplifier: பெரிய output-ஐ சுருக்க.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- நான்கு கேள்விகளில் உங்கள் வேலைக்கு எது பொருந்துகிறது?
- ஒரு Parallel வேலைக்கு எந்த rubric பயன்படுத்துவீர்கள்?$vd$, false),
('ai-agents-tamil', 10, $vd$அத்தியாயம் 7: Slash Commands: திரும்பத் திரும்ப வரும் வேலைக்கு ஒரு shortcut$vd$, $vd$ஒரே prompt-ஐ மீண்டும் மீண்டும் type செய்வதைத் தவிர்க்க Custom Slash Commands பயன்படுகின்றன. இந்த அத்தியாயம் எதை command ஆக்கலாம், எதை ஆக்கக்கூடாது, project-scoped மற்றும் user-scoped வேறுபாடு ஆகியவற்றை விளக்குகிறது.

கற்றல் நோக்கங்கள்

- Slash Command என்றால் என்ன என்று விளக்க முடியும்.
- எந்த workflow-ஐ command ஆக்கலாம் என்று தீர்மானிக்க முடியும்.
- Project scope மற்றும் User scope வேறுபாட்டைச் சொல்ல முடியும்.

## Custom Slash Commands

இது இன்னொரு practical concept.

ஒரே prompt-ஐ திரும்பித் திரும்ப type பண்ணிக்கிட்டு இருந்தா:

Use daily-content-draft agent...

Show plan first...

Do X...

Don't do Y...

Finally return...

every time எழுதுவது waste.

அதை ஒரு shortcut command-க்குள் package பண்ணுகிறோம்.

Example:

/draft my Friday post about firing my first employee

அவ்வளவுதான்.

Claude பின்னாடி full workflow invoke பண்ணும் என்ற model screenshot-ல் காட்டப்படுகிறது.

Another example:

/review security

அது predefined code-review workflow-ஐ trigger செய்யும்.

### Simple meaning

Long reusable prompt/workflow → ஒரு short command

## எதை Slash Command ஆக்கணும்?

Screenshot-ல நல்ல rule இருக்கு.

### ✅ Slash command ஆக்கலாம்

நீங்க 3+ times manually பண்ணி, consistently result நல்லா வந்த workflow.

Examples:

- Draft generation
- Code review
- Weekly recap
- Inbox sweep
- Metric pull
- Brainstorm

### ❌ Slash command ஆக்க வேண்டாம்

இன்னும் unstable-ஆ இருக்கிற workflow.

Prompt ஒவ்வொரு முறையும் change பண்ண வேண்டி இருந்தா, automate/package பண்ண நேரம் வரல.

Also one-time work:

ஒரு தடவை மட்டும் perform செய்ய வேண்டிய exploration/audit.

அதற்கு reusable command unnecessary.

Short version:

First make the workflow reliable. பிறகு shortcut உருவாக்கு.

## Project-scoped vs User-scoped Commands

Screenshot இன்னொரு useful separation கொடுக்கிறது.

### Project-scoped

ஒரு particular repo/project-க்கு மட்டும் relevant.

Examples:

/review

/test-this

/deploy-check

### User-scoped

நீங்க எந்த project-ல இருந்தாலும் உங்களுக்குத் தேவையான workflow.

Examples:

/draft

/inbox

/weekly-recap

நினைவில் வைக்க:

Codebase/project-ஐப் பொறுத்தது → Project scope

உங்க personal working style/habit-ஐப் பொறுத்தது → User scope

நீங்கள் கற்றுக்கொண்டவை

- நீண்ட reusable prompt/workflow → ஒரு short command.
- முதலில் workflow reliable ஆகட்டும்; பிறகு shortcut.
- Project-ஐப் பொறுத்தது → Project scope; personal habit → User scope.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- நீங்கள் 3 முறைக்கு மேல் செய்த ஒரு வேலை எது?
- அதை Project scope-ல் வைப்பீர்களா அல்லது User scope-ல் வைப்பீர்களா?$vd$, false),
('ai-agents-tamil', 11, $vd$அத்தியாயம் 8: Safety: Hooks மற்றும் Guardrails$vd$, $vd$Agent வேகமாகச் செயல்படுவதால், ஆபத்தான செயல் நடக்கும் முன் நிறுத்தும் விதி தேவை. அதுவே Hook. இந்த அத்தியாயம் பயனுள்ள Hook எடுத்துக்காட்டுகளையும், அவற்றை அதிகமாக்கக் கூடாது என்ற எச்சரிக்கையையும் விளக்குகிறது.

கற்றல் நோக்கங்கள்

- Hook என்றால் என்ன என்று சொல்ல முடியும்.
- ஆறு Hook எடுத்துக்காட்டுகளை விளக்க முடியும்.
- High-risk செயல்களுக்கு மட்டும் வலுவான guardrails வைக்கும் கொள்கையைப் புரிந்துகொள்ள முடியும்.

## Hooks என்ற Safety Net

![Hooks: செயல் நடக்கும் முன் தடுக்கும் பாதுகாப்பு வலை](image7)

இது இந்த lesson-ல மிகவும் important safety concept.

Agent fast-ஆ actions செய்யலாம்.

ஆனா dangerous action execute ஆவதற்கு முன்னாடி:

“Stop. Check this first.”

என்று நிறுத்துற rule தான் Hook.

Simple analogy:

Hook = Agent-க்கு seat belt + security gate.

உதாரணம்:

Agent ஒரு dangerous shell command execute பண்ண முயற்சிக்கிறது.

Hook:

Agent → Dangerous command → 🛑 Hook → Human approval

Approval வந்தால் மட்டும் continue.

## Useful Hook examples

Screenshots பல practical guardrails காட்டுது.

### Pre-bash guardrail

Dangerous shell commands detect பண்ணி human confirmation கேட்கலாம்.

Examples screenshot-ல்:

- destructive removal
- database dropping
- forced git pushes
- privileged operations

Concept:

Destructive command → pause → approval

### Pre-edit fact check

Important files modify பண்ணுவதற்கு முன்பு Agent:

“இந்த file-ஐ மாற்றப் போறேன்; இந்த changes செய்யப் போறேன்”

என்று surface பண்ண வேண்டும்.

உதாரணமாக important config / README / environment-related files.

### Scope-lock

Agent project folder-க்குள்ள மட்டும் write பண்ண அனுமதிப்பது.

அதாவது:

“இந்த project-க்கு வெளியே போகாதே.”

### Draft-only Mode

Content Agent:

❌ Send

❌ Publish

❌ Post

செய்யக்கூடாது.

Instead:

✅ Draft create பண்ணு

✅ Human review பண்ணட்டும்

### Commit Approval

Human approval இல்லாமல் commit செய்ய விடாத guardrail.

### Network Block

Offline-only Agent என்றால் unexpected internet/network access-ஐ block பண்ணுவது.

## Hooks-லயும் Over-engineering வேண்டாம்

Hooks நல்லது என்பதற்காக everything needs approval ஆக்கக்கூடாது.

அப்படி பண்ணிட்டா automation purpose-யே போயிடும்.

Course சொல்கிற nice analogy:

Hooks பூட்டு மாதிரி.

ரொம்பக் குறைவா இருந்தால் பாதுகாப்பு இல்லை.

ரொம்ப அதிகமா இருந்தால் நாமே உள்ளே செல்ல முடியாது. 😄

அதனால் high-risk actions-க்கு மட்டும் strong guardrails.

நீங்கள் கற்றுக்கொண்டவை

- Hook = Agent-க்கு seat belt + security gate.
- Destructive command → pause → approval.
- எல்லாவற்றுக்கும் approval வைத்தால் automation-ன் நோக்கமே இழக்கப்படும்.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் Agent செய்யக்கூடாத ஒரு ஆபத்தான செயல் எது?
- அதற்கு எந்த Hook பொருந்தும்?$vd$, false),
('ai-agents-tamil', 12, $vd$அத்தியாயம் 9: உங்கள் Agent தொகுப்பை உருவாக்குவது$vd$, $vd$தனித்தனி Agents-ஐ இணைத்து ஒரு Personal Agent Stack-ஐ உருவாக்குவது எப்படி என்பதை இந்த அத்தியாயம் விளக்குகிறது. எந்த Agents-ஐ உருவாக்குவது, எப்படிப் பெயரிடுவது, பயன்படுத்தாத Agents-ஐ என்ன செய்வது என்பதும் இதில் உள்ளது.

கற்றல் நோக்கங்கள்

- 3–5 பயனுள்ள Agents என்ற பரிந்துரையை விளக்க முடியும்.
- இரண்டு கேள்விகளைப் பயன்படுத்தி உங்கள் Agents-ஐத் தேர்ந்தெடுக்க முடியும்.
- முழு Architecture-ஐ ஒரே வரைபடமாகப் பார்க்க முடியும்.

## Personal Agent Stack

இதுவரை individual Agents பார்த்தோம்.

இப்ப screenshots எல்லாத்தையும் connect பண்ணி ஒரு Personal Agent Stack build பண்ணுது.

![Morning Briefing, Inbox Triage, Content Draft, CRM Updater, Weekly Report அடங்கிய Personal Agent Stack](image8)

Example:

You

├── Morning Briefing

├── Inbox Triage

├── Content Draft

├── CRM Updater

└── Weekly Report

Course-ன் interesting recommendation:

3–5 useful Agents போதும்.

50 Agents create பண்ணுவது objective இல்லை.

ஏன்?

5 Agents என்ன செய்கிறது என்று நினைவில் வைக்க முடியாத அளவுக்கு இருந்தால், stack complicated ஆகிடும்.

## எந்த Agents build பண்ணுவது?

Course ஒரு நல்ல practical method கொடுக்குது.

கடந்த சில நாட்களில் நீங்க repeatedly செய்த வேலைகளை எழுதுங்க.

உதாரணம்:

- Emails sort
- Status report
- Code review
- Metrics collect
- Meeting notes clean
- Draft preparation
- Research

பிறகு இரண்டு questions:

“எந்த 3 வேலை எனக்கு boring?”

அவை automation-க்கு strong candidates.

“எந்த 2 வேலை அதிக நேரம் எடுத்தது?”

அவை time-saving Agent candidates.

இதிலிருந்து initial Agent stack கிடைக்கும்.

## Agent Naming Discipline

ஒவ்வொரு Agent-க்கும் memorable name + one-line job இருக்கணும்.

Good examples:

inbox-triage

daily-content-draft

weekly-recap

code-review-buddy

research-runner

Agent name பார்த்தவுடன்:

“ஆமா, இது என்ன வேலை செய்யும்”

என்று நினைவுக்கு வரணும்.

## Dead Agents-ஐ வைத்துக்கொள்ள வேண்டாம்

Screenshot-ல் interesting housekeeping rule இருக்கு:

ஒரு Agent-ஐ நீண்ட காலமா use பண்ணவே இல்லைனா, அது உண்மையிலேயே தேவையா என்று பாருங்க.

Agent collection build பண்ணுவது goal இல்லை.

Useful operational system build பண்ணுவதுதான் goal.

## இந்த முழு lesson-ன் Architecture

Screenshot எல்லாத்தையும் ஒரே architecture-ஆ பார்த்தா:

YOU

↓

ORCHESTRATOR

↓

┌───────────────────────────┐

↓             ↓             ↓

Research       Draft        Review

↓             ↓             ↓

└────────── Result ─────────┘

↓

GUARDRAILS

↓

HUMAN REVIEW

↓

DONE

இதில்:

- Agent = worker
- Sub-agent = temporary specialist
- Agent Team = reusable specialists
- Orchestrator = coordinator
- Slash Command = shortcut to invoke workflow
- Hook = safety rule
- Stop Condition = Done definition
- Human = final authority

## உங்களுக்கு Architect perspective-ல முக்கியமான takeaway

இந்த course உண்மையில் “Claude எப்படி use பண்ணுவது?” மட்டும் teach பண்ணவில்லை.

இது essentially:

AI system design / delegation architecture

teach பண்ணுது.

உங்களுக்குத் தெரிந்த software architecture concepts-ஓட map பண்ணினா:

Agent → Service

Sub-agent → Temporary specialised worker

Orchestrator → Workflow coordinator

Slash Command → Simple interface / entry point

Hook → Policy / guardrail

Keys → Permissions

Stop Condition → Completion criteria

Agent stack → Small operational system

இந்த entire section-ஐ ஒரு sentence-ல் நினைவில் வைக்க:

“முதலில் ஒரு Agent-க்கு clear வேலை கொடுத்து reliable ஆக்கு; வேலை genuinely வேறு responsibilities-ஆ split ஆகும்போது மட்டும் specialists உருவாக்கு; Orchestrator மூலம் coordinate பண்ணு; Hooks மூலம் risky actions-ஐ control பண்ணு; repeat ஆகிற stable workflows-ஐ slash commands/automation-ஆ மாற்று.”

இதுதான் இந்த 16 screenshots சொல்லும் core idea.

நீங்கள் கற்றுக்கொண்டவை

- 50 Agents உருவாக்குவது நோக்கமல்ல; பயனுள்ள செயல்பாட்டு அமைப்பே நோக்கம்.
- ஒவ்வொரு Agent-க்கும் நினைவில் நிற்கும் பெயரும் ஒரு வரி Job-ம் தேவை.
- பயன்படுத்தாத Agent-ஐ வைத்துக்கொள்ள வேண்டாம்.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- கடந்த சில நாட்களில் நீங்கள் திரும்பத் திரும்பச் செய்த வேலைகளைப் பட்டியலிடுங்கள்.
- “எந்த 3 வேலை எனக்கு boring?” என்ற கேள்விக்கு உங்கள் பதில் என்ன?$vd$, false),
('ai-agents-tamil', 13, $vd$அத்தியாயம் 10: நேரம் மற்றும் Event அடிப்படையில் Automation$vd$, $vd$நாம் இல்லாமலேயே வேலை நடக்க வைப்பது எப்படி என்பதை இந்த அத்தியாயம் விளக்குகிறது: /loop, One-time reminder, Routine, Tiny Automation, Webhook மற்றும் அவற்றின் வேறுபாடுகள்.

கற்றல் நோக்கங்கள்

- Scheduling-ன் மூன்று நிலைகளைச் சொல்ல முடியும்.
- Routine மற்றும் Webhook வேறுபாட்டை விளக்க முடியும்.
- Webhook-ல் ஏற்படும் ஆபத்தான தவறை எப்படித் தவிர்ப்பது என்று சொல்ல முடியும்.

## Scheduling: நாம இல்லாமலேயே வேலை நடக்க வைப்பது

Claude Code ஒரு task-ஐ schedule பண்ணி மறுபடியும் run செய்ய முடியும் என்று screenshot explain செய்கிறது.

இதில் 3 levels காட்டப்பட்டிருக்கு.

![Scheduling: காலை, மதியம், மாலை, நள்ளிரவு நேரங்களில் தானாக நடக்கும் வேலைகள்](image9)

### Level 1: /loop

Session open இருக்கும்போது repeated checking.

Example screenshot:

/loop 1h check [inbox/folder/feed]

for anything matching [criteria]

and post me a one-line summary of anything new

அதாவது:

“ஒவ்வொரு 1 மணி நேரத்துக்கும் இதை check பண்ணு. புதுசா ஏதாவது இருந்தா ஒரு line summary கொடு.”

இது temporary monitoring மாதிரி.

Screenshot படி இது அந்த session-க்குள் இருக்கும் மற்றும் auto-expire ஆகும் என்பதால் short-term monitoring-க்கு use பண்ணலாம். [ஆசிரியர் சரிபார்க்க வேண்டும்]

### Level 2: One-time reminder

உதாரணம்:

“3 PM-க்கு இந்த update post பண்ண நினைவுபடுத்து.”

ஒரே தடவை run ஆகும் reminder/task.

### Level 3: Routine

இது actual recurring automation.

Example:

Every weekday morning → நேற்று நடந்ததை summarise பண்ணு → 3 bullets கொடு → எனக்காக ready-ஆ வை.

இதுதான் real scheduled Agent workflow.

Simple-ஆ:

Agent + Schedule = Routine

## Tiny Automation

Course இங்கே ஒரு நல்ல principle கொடுக்குது:

Small chains beat big agents.

ஒரு huge “super agent” எல்லாத்தையும் செய்ய வைக்கிறதை விட:

Trigger → Do → Notify

என்ற simple automation better.

உதாரணம்:

![Trigger, Do, Notify என்ற சிறிய automation சங்கிலி](image10)

Every Friday 5 PM

↓

இந்த வார notes/numbers collect பண்ணு

↓

Short recap draft பண்ணு

↓

என் approval-க்கு வை

இதில் important point:

Automation எல்லாத்தையும் செய்யட்டும். Final authority நம்மகிட்ட இருக்கட்டும்.

## முதல் Automation எப்படி தேர்ந்தெடுக்கணும்?

Screenshot கொடுத்த examples practical-ஆ இருக்கு:

### Weekly recap

Every Friday → இந்த வார wins/numbers/notes collect → short recap → approval.

### Inbox automation

Morning → matching emails scan → reply drafts தயார் பண்ணு → send பண்ணாதே.

### Notes cleanup

வாரத்திற்கு ஒருமுறை → new notes read → clean formatted summary build பண்ணு.

Common pattern கவனிங்க:

Trigger

↓

Predictable Task

↓

Draft / Result

↓

Human Approval

## Golden Rule: முதலில் manual, பிறகுதான் Automation

இந்த screenshots திரும்பத் திரும்ப சொல்லும் முக்கியமான principle:

ஒரு workflow-ஐ முதலில் manually run பண்ணி பாருங்க. அது reliable-ஆ வேலை செய்கிறது என்று தெரிந்த பிறகு schedule பண்ணுங்க.

அதாவது:

❌ Build → Immediately automate

✅ Build → Run → Watch → Fix → Run again → Trust → Automate

Previous lesson-ல பார்த்த அதே principle இங்கும் தொடருது.

Schedule what you trust, not what you hope.

## Routine vs Webhook

இது கண்டிப்பா நினைவில் வைத்துக்கொள்ள வேண்டிய difference.

### Routine = TIME decides

ஒரு குறிப்பிட்ட நேரத்தில் run ஆகணும்.

உதாரணம்:

Every Monday 9 AM

↓

Weekly report

அதாவது clock trigger.

### Webhook = EVENT decides

ஒரு event நடந்த உடனே trigger ஆகும்.

உதாரணம்:

New lead received

↓

Webhook

↓

Agent

↓

Lead analyse

↓

Reply draft

↓

Human approval

இதில் “Monday 9 AM” கிடையாது.

Event வந்ததுதான் trigger.

## Webhook-ஐ மிக simple-ஆ புரிந்துகொள்ளலாம்

Screenshot-ன் explanation-ஐ normal Tamil-ல சொன்னா:

Webhook ஒரு public URL endpoint மாதிரி.

External system-ல ஏதாவது event நடந்தால், அந்த system இந்த endpoint-க்கு data அனுப்பும்.

உதாரணம்:

Website form submitted

↓

Webhook

↓

Agent receives data

↓

Process

↓

Draft result

Screenshot examples:

### New Lead

Form → webhook → agent reads → score → response draft → approval

### Payment

Payment event → webhook → agent → CRM-related action → welcome draft

### Social message/comment

Comment/DM → webhook → agent → reply draft → approval

இதனால்:

Routine = predictable time-based work

Webhook = unpredictable event-based work

## Routine + Webhook சேர்ந்தா?

இரண்டுமே தேவைப்படலாம்.

உதாரணம்:

### Routine

தினமும் காலை status summary.

### Webhook

New customer enquiry வந்தவுடன் process.

இதுதான் screenshot சொல்லும் pairing:

Predictable work → Routine

Unpredictable event → Webhook

எல்லாத்துக்கும் webhook போட வேண்டாம். எல்லாத்தையும் routine-ஆவும் செய்ய வேண்டாம்.

## Webhook-ல dangerous mistake

இது ரொம்ப important.

Webhook வந்ததும் Agent automatic-ஆ customer-க்கு email அனுப்புவது ஆரம்பத்திலேயே risky.

Example:

Payment webhook

↓

Agent

↓

Wrong/unreviewed message

↓

Customer 😬

Course recommend பண்ற model:

Webhook

↓

Agent creates Draft

↓

Known location

↓

Human Approval

↓

External Action

அதாவது ஆரம்பத்தில:

Auto-process செய்யலாம். Auto-send வேண்டாம்.

நீங்கள் கற்றுக்கொண்டவை

- Routine = நேரம் தீர்மானிக்கிறது; Webhook = event தீர்மானிக்கிறது.
- முதலில் manual-ஆக இயக்கி, நம்பிக்கை வந்த பிறகே schedule செய்யுங்கள்.
- ஆரம்பத்தில் Auto-process செய்யலாம்; Auto-send வேண்டாம்.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் ஒரு வேலை Routine-க்கு ஏற்றதா அல்லது Webhook-க்கு ஏற்றதா?
- அந்த வேலையில் Human approval எங்கே வர வேண்டும்?$vd$, false),
('ai-agents-tamil', 14, $vd$அத்தியாயம் 11: Git Worktrees மற்றும் பல Claude Sessions$vd$, $vd$ஒரு நீண்ட வேலை நடந்துகொண்டிருக்கும்போது அவசர வேலை வந்தால் என்ன செய்வது? இந்த அத்தியாயம் Git worktree, அதை எப்போது பயன்படுத்தலாம், “3-Session Ceiling” என்ற யோசனை மற்றும் பொதுவான தவறுகளை விளக்குகிறது.

கற்றல் நோக்கங்கள்

- Git worktree என்றால் என்ன என்று சொல்ல முடியும்.
- Worktree பயனுள்ள மற்றும் தேவையற்ற சூழல்களை அடையாளம் காண முடியும்.
- Review வேகமே bottleneck என்பதை விளக்க முடியும்.

## Worktree என்றால் என்ன?

இந்த section developer/architect angle-ல உங்களுக்கு useful.

ஒரு long Claude session ஒரு பெரிய code change/refactoring பண்ணிக்கிட்டு இருக்கு என்று வைத்துக்கொள்ளலாம்.

அப்போ திடீரென்று:

“ஒரு urgent small bug fix பண்ணணும்.”

Current session-ஐ interrupt பண்ணினா context disturb ஆகும்.

அதற்குத்தான் Git worktree.

Simple mental model:

Same project-ன் இன்னொரு working folder + வேறு branch.

### Worktree Flow

Example screenshot:

Brain 1

Branch: refactor/payments

Big refactoring நடந்துகொண்டிருக்கிறது.

Brain 2

Separate worktree:

Branch: hotfix/login-redirect

Quick bug fix.

இரண்டும் parallel-ஆ run ஆகலாம்.

Conceptually:

Same Repository

│

├── Folder A → Branch A → Claude Session A

│

└── Folder B → Branch B → Claude Session B

ஒரு session மற்ற session-ன் files-ஐ overwrite பண்ணாமல் தனித்த working folder-ல் இருக்கும்.

## Worktree எப்போது useful?

Screenshot மூன்று நல்ல situations சொல்கிறது.

### ① Long task + quick unrelated fix

Big refactor ஓடிக்கொண்டிருக்கிறது.

Meanwhile small urgent fix வந்திருக்கு.

### ② A/B approach

ஒரே problem-க்கு இரண்டு solution try பண்ணலாம்.

Worktree A → Approach A

Worktree B → Approach B

கடைசியில் diff/result compare பண்ணலாம்.

### ③ Demo/Review + Development

ஒரு branch-ஐ review/demo பண்ணும்போது மற்றொரு branch-ல் Claude வேறு work continue பண்ணலாம்.

## Worktree எப்போது வேண்டாம்?

Course explicit-ஆ சொல்கிறது:

### ❌ Normal solo task

One branch, one task என்றால் worktree unnecessary.

### ❌ இரண்டு branches-க்கும் shared live state தேவை

Git branches intentionally independent.

Closely coupled real-time work என்றால் இது ideal model இல்லை.

### ❌ “Parallel cool-ஆ இருக்கு” என்பதற்காக மட்டும்

Tool இருக்கிறது என்பதற்காக architecture உருவாக்க வேண்டாம்.

## “3-Session Ceiling”

இது இந்த screenshots-ல முக்கியமான productivity idea.

Worktrees பார்த்ததும்:

“அப்படின்னா 5 Claude, 10 Claude parallel-ஆ run பண்ணலாமே!”

என்று தோணலாம்.

Course சொல்றது: அது productivity increase ஆகாம reverse ஆகலாம்.

Screenshot recommend செய்யும் practical ceiling:

ஒரே நேரத்தில் சுமார் 3 Claude sessions. [ஆதாரம் சேர்க்க வேண்டும்]

ஏன்?

ஒவ்வொரு Agent/session-க்கும் இரண்டு இடங்களில் human attention தேவை:

- ஆரம்பத்தில் brief
- முடிவில் review

Claude faster ஆகிவிட்டாலும், review செய்ய வேண்டியது நீங்கதான்.

அதனால் bottleneck:

AI execution speed → Human review speed

ஆக மாறிடும்.

## 3 sessions-ஐ எப்படி பயன்படுத்தலாம்?

Screenshot ஒரு useful model கொடுக்கிறது:

### Session 1: Long-running

Big refactor / build / research.

### Session 2: Short-cycle

Quick fix / small feature.

### Session 3: Review + Merge

மற்ற இரண்டு sessions output-ஐ inspect பண்ணி merge/commit side handle செய்வது.

Architect mindset-ல:

Session A = Builder

Session B = Fast Task

Session C = Reviewer / Integrator

இதுதான் random-ஆ மூன்று Claudes run செய்வதை விட sensible.

## Most important lesson: More Claude ≠ More Productivity

Course சொல்லும் subtle point:

AI instances அதிகப்படுத்துவது objective இல்லை.

நீங்க இரண்டு sessions output-யே properly review பண்ண முடியலனா இன்னொரு Claude opening:

❌ Productivity improve பண்ணாது

❌ Backlog உருவாக்கும்

❌ Unreviewed work அதிகப்படுத்தும்

அதனால்:

புதிய Claude session add பண்ண வேண்டிய signal = execution slow என்பதல்ல; existing outputs review செய்வதுதான் bottleneck இல்லை என்று உறுதியான பிறகுதான்.

## Beginner mistakes இந்த section-ல

### ❌ Automation ready ஆகும் முன் schedule செய்வது

“Run ஆகுது” ≠ “Reliable”.

### ❌ Webhook வந்ததும் external action

Human approval இல்லாமல் customer-facing action trigger செய்வது ஆரம்பத்தில avoid பண்ணணும்.

### ❌ Too many routines

5 scheduled automations create பண்ணிவிட்டு எந்த output-யும் review செய்யாமல் விட்டால் system useful இல்லை.

### ❌ Too many worktrees/sessions

Parallel-ஆ நிறைய things start பண்ணிட்டு review backlog create பண்ணுவது.

### ❌ Weak briefs

Parallel Claude sessions-க்கு rushed instruction கொடுத்தால் garbage output parallel-ஆ வேகமா வரும் 😄

### ❌ Unreviewed merge = done என்று நினைப்பது

Course-ன் view:

நீங்க review பண்ணாத merge உண்மையில் finished work கிடையாது.

## இந்த முழு section-ஐ ஒரு Architecture-ஆ பாருங்க

YOU

│

Define / Approve

│

┌────────┴─────────┐

│                  │

ROUTINE            WEBHOOK

(Time Trigger)      (Event Trigger)

│                  │

└────────┬─────────┘

↓

AGENT

↓

DO THE WORK

↓

DRAFT / RESULT

↓

HUMAN REVIEW

↓

EXTERNAL ACTION

Developer work parallel-ஆ செய்ய வேண்டும்னா:

Git Repository

↓

┌────┴────┐

↓         ↓

Worktree A Worktree B

↓         ↓

Claude A   Claude B

└────┬────┘

↓

Human Review

↓

Merge

நீங்கள் கற்றுக்கொண்டவை

- Worktree = அதே project-ன் இன்னொரு working folder + வேறு branch.
- ஒரே நேரத்தில் சுமார் 3 sessions என்பது நடைமுறை எல்லையாகக் கூறப்படுகிறது.
- More Claude ≠ More Productivity; Review செய்யாத merge முடிந்த வேலை அல்ல.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் வேலையில் இரண்டு வேலைகளை parallel-ஆகச் செய்ய வேண்டிய சூழல் உள்ளதா?
- அவற்றின் output-ஐ நீங்கள் எவ்வளவு வேகத்தில் review செய்ய முடியும்?$vd$, false),
('ai-agents-tamil', 15, $vd$அத்தியாயம் 12: முழுப் பயணம்: ஒரே பார்வையில்$vd$, $vd$இதுவரை படித்த அனைத்தையும் ஏழு கட்டங்களாக இணைத்து, ஒரு Agent எப்படி manual வேலையிலிருந்து நம்பகமான automation-க்கு வளர்கிறது என்பதை இந்த அத்தியாயம் காட்டுகிறது.

கற்றல் நோக்கங்கள்

- ஏழு கட்டங்களையும் வரிசையாகச் சொல்ல முடியும்.
- Manual → Agent → Reliable Agent → Guardrails → Repeatable workflow → Automation என்ற வரிசையை விளக்க முடியும்.
- இறுதி இலக்கை ஒரு வாக்கியத்தில் சொல்ல முடியும்.

## Previous lessons + இந்த lesson சேர்த்தால்

இப்போ overall picture நல்லா complete ஆகுது:

### Phase 1: Agent உருவாக்குறீங்க

Name + Soul + Job + Keys + Stop Condition

### Phase 2: Work delegate பண்றீங்க

Scope + Steps + Guardrails + Report-back

### Phase 3: Complexனா split பண்றீங்க

Orchestrator + Sub-agents

### Phase 4: Safety add பண்றீங்க

Hooks + Human approval

### Phase 5: Repeated workflow package பண்றீங்க

Slash Command

### Phase 6: Proven workflow automate பண்றீங்க

Routine / Webhook

### Phase 7: Independent developer work parallelise பண்றீங்க

Git Worktrees + Multiple Claude Sessions

## உங்களுக்கு நான் சொல்லும் practical takeaway

நீங்க Architect என்பதால், “Agent உருவாக்கணும்” என்ற excitement-ஐ விட இந்த progression-ஐ மனசுல வச்சுக்கிறது useful:

Manual → Agent → Reliable Agent → Guardrails → Repeatable workflow → Automation

இதைக் reverse பண்ணக்கூடாது.

அதாவது:

முதலில் intelligence-ஐ automate பண்ணாதீங்க. முதலில் ஒரு நல்ல working process உருவாக்குங்க. அந்த process repeatable + trustworthy ஆன பிறகு automation சேர்க்குங்க.

இந்த screenshots முழுக்க எனக்கு தெரியும் மிக முக்கியமான message:

Claude வேகமாக வேலை செய்யுது என்பதால நாம அதிக வேலை start பண்ணுவது goal இல்லை. Claude செய்யும் வேலையை நாம குறைந்த effort-ல confidently review செய்து approve செய்யக்கூடிய system build பண்ணுவதுதான் goal.

நீங்கள் கற்றுக்கொண்டவை

- முதலில் நல்ல working process; பிறகே automation.
- Agent, Delegation, Sub-agents, Safety, Slash Command, Routine/Webhook, Worktrees என்பவை ஏழு கட்டங்கள்.
- இலக்கு: குறைந்த முயற்சியில் நம்பிக்கையுடன் review செய்து approve செய்யக்கூடிய அமைப்பு.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- இப்போது நீங்கள் எந்தக் கட்டத்தில் இருக்கிறீர்கள்?
- அடுத்த கட்டத்துக்குச் செல்ல என்ன தேவை?$vd$, false),
('ai-agents-tamil', 16, $vd$அத்தியாயம் 13: 🛠️ Building Your First Agent End-to-End$vd$, $vd$இந்த அத்தியாயத்தில் daily-content-draft என்ற Agent-ஐ படிப்படியாக உருவாக்குகிறோம்: file உருவாக்குவது முதல் Soul, Job, Keys, Stop Condition எழுதுவது, முதல் run, மற்றும் Agent file-ஐ மேம்படுத்துவது வரை.

கற்றல் நோக்கங்கள்

- ஒரு Agent file-ஐ உருவாக்கி அதன் structure-ஐப் புரிந்துகொள்ள முடியும்.
- Soul, Job, Keys, Stop Condition ஆகியவற்றை எழுத முடியும்.
- Prompt-ஐ அல்ல, Agent file-ஐ சரி செய்யும் பழக்கத்தை விளக்க முடியும்.

இந்த lesson-ல example:

![Prompt கொடுத்தால் இணையப் பக்கம் உடனே உருவாகும் என்பதைக் காட்டும் விளக்கப்படம்](image11)

daily-content-draft

இதன் வேலை:

நீங்க ஒரு rough idea கொடுத்தால், உங்க writing style / voice-ல 3 விதமான post drafts தயார் பண்ணி file-ஆ save பண்ணும். ஆனால் எங்கும் post/send பண்ணாது.

## Step 1: Agent-க்கு ஒரு file உருவாக்குறோம்

Project-க்குள் இந்த location-ல Agent file create பண்ண சொல்றாங்க:

/.claude/agents/daily-content-draft.md

Claude Code-க்கு:

Create a new agent file at

.claude/agents/daily-content-draft.md

and open it for me to edit.

Don't write anything in it yet.

என்று சொல்லலாம்.

### ஏன் .md file?

இதை ஒரு சாதாரண configuration/instruction file மாதிரி நினைச்சுக்கலாம்.

அதுக்குள்ள தான் Agent-ன்:

- Name
- Description
- Tools
- Soul
- Job
- Keys
- Stop condition

எல்லாம் define பண்ணப்படுது.

## Step 2: Agent-க்கு identity + behaviour கொடுக்குறோம்

Screenshot-ல roughly இந்த structure இருக்கு:

name: daily-content-draft

description: Drafts 3 post options in my voice

tools: Read, Write

இதுக்குக் கீழே actual instructions வருகின்றன.

### 🧠 SOUL

SOUL என்றால்:

Agent எப்படி எழுதணும் / behave பண்ணணும்?

Screenshot example-ல் Agent ஒரு ghostwriter மாதிரி behave செய்ய வேண்டும்.

அது user உண்மையிலேயே எப்படி பேசுறாரோ அந்த style-ல எழுதணும்.

For example:

- Punchy-ஆ எழுதணுமா?
- Thoughtful-ஆ?
- Short sentences வேண்டுமா?
- Long sentences வேண்டுமா?
- Emoji use பண்ணலாமா?
- சில words avoid பண்ணணுமா?

இதெல்லாம் SOUL-ல define பண்ணலாம்.

சிம்பிளா சொன்னா:

JOB = என்ன செய்யணும்

SOUL = அதை எந்த style-ல செய்யணும்

## Step 3: JOB

Screenshot example-ல் rough idea கொடுத்தால் exactly 3 versions உருவாக்க சொல்லியிருக்காங்க.

### Version 1

Short hook-driven version.

சுமார் 280 characters.

### Version 2

Medium story version.

சுமார் 3 short paragraphs.

### Version 3

Long teaching version.

User notes-லிருந்து relevant example கிடைத்தால் அதைச் சேர்த்து detailed version.

அதாவது Agent-க்கு:

“Draft எழுது”

என்று vague-ஆ சொல்லவில்லை.

Output எப்படி இருக்கணும் என்பதே predefined.

அதுதான் நல்ல Agent design.

## 🔑 Step 4: KEYS / Tools scope

இதுதான் security point.

இந்த Agent-க்கு screenshot-ல்:

tools: Read, Write

மட்டும்தான்.

அதாவது Agent-க்கு வேலை செய்ய என்ன tools உண்மையில் தேவையோ, அது மட்டும்.

Screenshot specifically சொல்றது:

Default to the fewest tools that get the job done.

அதாவது:

“Might need it someday”னு permission கொடுக்காதீங்க.

இந்த Agent-க்கு:

✅ Content library read access

✅ Draft folder write access

ஆனால் screenshot instructions படி:

❌ Internet வேண்டாம்

❌ Email வேண்டாம்

❌ Post/publish வேண்டாம்

இதுதான் நாம் previous lesson-ல பார்த்த least privilege idea.

## 🛑 Step 5: STOP CONDITION

Agent எப்போது:

“என் வேலை முடிஞ்சது”

என்று stop பண்ணணும்?

அது explicit-ஆ define செய்யப்படுகிறது.

Screenshot example-ல்:

- மூன்று files எழுதப்பட்டிருக்கணும்.
- குறிப்பிட்ட drafts location-ல் இருக்கணும்.
- மூன்று filenames + ஒவ்வொன்றோட hook-ஐ ஒரு 3-line summary-ஆ சொல்லணும்.
- பிறகு நிறுத்தணும்.

அதுக்கப்புறம் Agent:

Wait for me.

அதாவது தேவையில்லாமல் அடுத்த action எடுக்கக்கூடாது.

இதுதான் Agent-க்கு clean boundary.

## ▶️ Step 6: First Run

இப்ப Agent definition தயார்.

Claude Code-ல்:

Use the daily-content-draft agent on this idea:

"[your rough idea here]"

என்று கொடுக்குறோம்.

Claude என்ன செய்யும் என்று screenshot சொல்கிறது:

Agent file படிக்கும்

↓

SOUL எடுத்துக்கொள்ளும்

↓

JOB execute செய்யும்

↓

STOP CONDITION வந்ததும் நிறுத்தும்

### முக்கியமான point

முதல் run-ல output perfect-ஆ வரும் என்று எதிர்பார்க்கக்கூடாது.

முதல் run ஒரு test.

Agent எப்படி behave செய்கிறது என்று கவனிக்கணும்.

## ⭐ மிக முக்கியமான Step 7: Prompt-ஐ fix பண்ணாதீங்க, Agent FILE-ஐ fix பண்ணுங்க

இந்த screenshot-ல் எனக்கு மிகவும் பிடித்த concept இதுதான்.

Suppose Agent எழுதிய content:

“இது என் voice மாதிரி இல்லை.”

அப்போ அடுத்த prompt-ல்:

Make it more concise.

Don't use these words.

Use shorter sentences.

...

என்று patch போட்டுக்கொண்டே போகக்கூடாது.

Instead:

👉 Agent-ன் SOUL section-ஐ update பண்ணுங்க.

### ஏன்?

Prompt-ஐ மட்டும் fix பண்ணினா:

Session ends

↓

Fix disappears

Agent file-ஐ fix பண்ணினா:

Agent file updated

↓

Next run

↓

Same improvement exists

↓

Future runs improve

Screenshot இதை ரொம்ப நல்லா சொல்லுது:

Every fix to the file is permanent; every fix to the prompt evaporates when you close the session.

அதாவது Agent-ஐ ஒரு employee மாதிரி எடுத்துக்கோங்க.

ஒவ்வொரு நாளும் அதே correction சொல்லிக்கொண்டிருப்பதை விட:

Operating instructions-லேயே correction சேர்த்துடுங்க.

## 🧪 எத்தனை தடவை Test பண்ணணும்?

Screenshot recommendation:

Different rough ideas வைத்து இன்னும் 2 முறை run பண்ணிப் பாருங்க.

அதாவது roughly:

Run 1 → Observe → Fix Agent file

Run 2 → Observe → Fix Agent file

Run 3 → Observe

மூன்றாவது run வரும்போது output consistently உங்க voice-க்கு match ஆக ஆரம்பிக்கணும் என்பது lesson-ன் target.

Match ஆகலைனா SOUL section probably too short/vague.

அப்போ:

- இன்னும் 1–2 lines style instructions add பண்ணலாம்
- ஒரு sample post add பண்ணலாம்

## 🧠 இதை Software Engineering angle-ல புரிஞ்சுக்கோங்க

Architect perspective-ல இதை இப்படிப் பார்க்கலாம்.

### ❌ Prompt patching

ஒவ்வொரு runtime-லும்:

if this happens, do this...

actually don't do that...

make this shorter...

remember this...

என்று runtime correction கொடுத்துக்கொண்டே இருப்பது.

### ✅ Agent-file improvement

Root behaviour-ஐ:

Agent Definition

↓

Stable Behaviour

↓

Reusable Runs

ஆக மாற்றுவது.

அதாவது prompt engineering-லிருந்து configuration/design engineering-க்கு shift.

## முழு Agent எப்படி இருக்கிறது?

இந்த screenshots மட்டும் வைத்து mental model:

daily-content-draft

│

├── NAME

│   └── நான் யார்?

│

├── DESCRIPTION

│   └── நான் என்ன செய்கிறேன்?

│

├── TOOLS

│   └── என்ன access இருக்கு?

│

├── SOUL

│   └── நான் எப்படி behave/write செய்யணும்?

│

├── JOB

│   └── Exact task என்ன?

│

├── KEYS

│   └── எங்கே read/write செய்யலாம்?

│

└── STOP CONDITION

└── எந்த point-ல் நிறுத்தணும்?

## 🔥 இந்த lesson-ன் உண்மையான takeaway

இதை content-writing example-ஆ மட்டும் பார்க்காதீங்க.

இதே pattern-ஐ developer/architect work-க்கும் apply பண்ணலாம்.

உதாரணத்துக்கு hypothetical-ஆ:

architecture-reviewer

என்ற Agent வைத்தால் conceptually:

### SOUL

Strict architecture reviewer. Evidence இல்லாமல் assumptions செய்யக்கூடாது.

### JOB

Design document/code change review செய்து architecture concerns identify பண்ணு.

### KEYS

Relevant project files read மட்டும். தேவையில்லாத write/external action கிடையாது.

### STOP CONDITION

Review findings கொடுத்ததும் stop. தானாக implementation change செய்யாதே.

இதுதான் same pattern.

## இதுவரை நீங்க படித்த Stage 7-ஐ ஒரே flow-ல்

- Agent என்றால் என்ன?

↓

- Scope எப்படி define பண்ணுவது?

↓

- Name + Soul + Job + Keys + Stop Condition

↓

- தேவைப்பட்டால் Sub-agents

↓

- Orchestrator மூலம் coordinate

↓

- Hooks மூலம் safety

↓

- Stable workflow-ஐ Slash Command ஆக்கு

↓

- Proven workflow-ஐ Routine/Webhook மூலம் automate பண்ணு

↓

- இப்ப actual .claude/agents/...md file create பண்ணி real Agent build பண்ணு

## 🎯 ஒரு sentence-ல்:

ஒரு நல்ல Agent என்பது பெரிய clever prompt கிடையாது. அது clear job + consistent behaviour + minimum permissions + measurable stopping point கொண்ட reusable worker.

மேலும் இந்த screenshot சொல்லும் மிக practical lesson:

Agent தவறு செய்தால் ஒவ்வொரு முறையும் prompt-ல் correction கொடுக்காதீங்க. அந்தத் தவறு மறுபடியும் நடக்காமல் Agent definition-ஐ improve பண்ணுங்க.

இந்த concept புரிஞ்சுட்டா, Stage 7-ன் பெரிய பகுதி click ஆயிடும்.

நீங்கள் கற்றுக்கொண்டவை

- Agent file-ல் Name, Description, Tools, Soul, Job, Keys, Stop condition வரையறுக்கப்படுகின்றன.
- முதல் run ஒரு test; 2–3 முறை சோதித்து Agent file-ஐ மேம்படுத்த வேண்டும்.
- Agent file-ல் செய்யும் திருத்தம் நிரந்தரம்; prompt-ல் செய்யும் திருத்தம் session முடிந்ததும் மறைந்துவிடும்.

சிந்தித்துப் பார்க்க / செய்து பார்க்க

- உங்கள் சொந்த Agent-க்கு ஒரு Name மற்றும் ஒரு வாக்கிய Job எழுதுங்கள்.
- முதல் run-ல் வரும் குறைகளை Agent file-ல் எப்படிச் சேர்ப்பீர்கள்?$vd$, false),
('ai-agents-tamil', 17, $vd$பின்னிணைப்பு A: Agent file-களை எங்கே வைப்பது?$vd$, $vd$ஆமாம் 👍 நீங்களே agents folder create பண்ணலாம். Screenshot-ல் C:\Users\[பயனர் பெயர்]\.claude இருக்கிறது, ஆனால் agents folder இல்லை. அது problem இல்லை.

Claude Code official docs படி custom subagents Markdown files-ஆ .claude/agents/ directory-ல் define செய்யப்படுகின்றன. [code.claude.com], [code.claude.com]

## உங்களுக்கு இரண்டு choices இருக்கு

### 1. எல்லா projects-க்கும் use செய்யும் personal agent என்றால்:

C:\Users\[பயனர் பெயர்]\.claude\agents

இதுதான் உங்கள் current screenshot-க்கு பொருத்தமான location.

அங்கே manually:

- agents என்ற folder create பண்ணுங்க.
- அதுக்குள் agent Markdown file create பண்ணுங்க.

Example:

C:\Users\[பயனர் பெயர்]\.claude\agents\daily-content-draft.md

User-level agents ~/.claude/agents/ location-ல் இருக்கலாம் என்று documentation குறிப்பிடுகிறது. [code.claude.com], [allahabadi.dev]

### 2. ஒரு particular project-க்கு மட்டும் agent வேண்டும் என்றால்:

Project folder-க்குள்:

my-project

.claude

agents

daily-content-draft.md

அதாவது:

[திட்டத்தின் பெயர்]\.claude\agents

இந்த agent அந்த project-க்கு scoped. Official docs .claude/agents/ directories-ல் filesystem-based agents define செய்யப்படுவதை உறுதிப்படுத்துகிறது. [code.claude.com]

## உங்களுக்கு இப்போது நான் recommend செய்வது

Course-ஐ learn/test பண்ணிக்கிட்டு இருப்பதால், screenshot-ல் இருக்கிற:

C:\Users\[பயனர் பெயர்]\.claude

க்குள்ளே simply:

agents

folder create பண்ணுங்க.

Final structure:

C:\Users\[பயனர் பெயர்]\.claude

├── agents

│    └── daily-content-draft.md

├── backups

├── cache

├── downloads

├── plugins

├── projects

├── sessions

├── state

└── settings.json

Important: agents folder default-ஆ already இருக்கணும்னு அவசியமில்லை. Custom agent இன்னும் create செய்யாததால் folder இல்லாமல் இருப்பது இயல்பான situation.

நீங்க course-ல இருக்குற daily-content-draft.md first agent-ஐ create பண்ணுறீங்கனா, அடுத்த step-ஆ அந்த .md file-க்குள் exactly என்ன எழுதணும்னு நம்ம சேர்ந்து build பண்ணலாம்.$vd$, false),
('ai-agents-tamil', 18, $vd$சொற்களஞ்சியம் (Glossary)$vd$, $vd$- ஏஜென்ட் (Agent): Goal, Tools, Permission கொடுத்தால் பல படிகளைத் தானாகச் செய்து முடிவைக் கொண்டுவரும் AI.
- துணை ஏஜென்ட் (Sub-agent): ஒரு குறிப்பிட்ட வேலைக்காக Main Agent பயன்படுத்தும் தற்காலிக helper.
- ஒருங்கிணைப்பாளர் (Orchestrator): வேலையைப் புரிந்து, எந்த specialist தேவை என்று முடிவுசெய்து, முடிவுகளை ஒருங்கிணைக்கும் Agent.
- ஏஜென்ட் குழு (Agent Team): தனி identity, Job, Soul, Tools கொண்ட நிரந்தர, மறுபயன்பாட்டு specialists.
- வேலை வரம்பு (Scope): Agent எங்கே, எதில் மட்டும் வேலை செய்யலாம் என்ற எல்லை.
- பணி விளக்கம் (Brief): Scope, Steps, Guardrails, Report-back ஆகியவை அடங்கிய வேலை ஒப்படைப்பு.
- பாதுகாப்பு விதிகள் (Guardrails): Agent செய்யக்கூடாதவற்றை வரையறுக்கும் விதிகள்.
- அறிக்கை திருப்புதல் (Report-back): வேலை முடிந்ததும் Agent என்ன செய்தது என்று சொல்லும் அறிக்கை.
- பெயர் (Name): Agent-க்கு வைக்கும் சுருக்கமான, நினைவில் நிற்கும் பெயர்.
- ஆன்மா (நடத்தை) (Soul): Agent-ன் personality, behaviour மற்றும் எழுதும் / செயல்படும் style.
- வேலை (Job): Agent-ன் ஒரே முக்கிய mission; ஒரு வாக்கியத்தில் சொல்லக்கூடியது.
- சாவிகள் (அனுமதிகள்) (Keys): Agent பயன்படுத்தக்கூடிய tools, folders மற்றும் access.
- நிறுத்த நிபந்தனை (Stop Condition): வேலை முடிந்தது என்பதை Agent எப்படி அறியும் என்ற அளவிடக்கூடிய வரையறை.
- குறைந்தபட்ச அனுமதி (Least privilege): வேலைக்குத் தேவையான access மட்டும் கொடுக்கும் கொள்கை.
- மனித ஒப்புதல் (Human approval): முக்கிய செயலுக்கு முன் மனிதர் சரிபார்த்து ஒப்புக்கொள்வது.
- ஸ்லாஷ் கட்டளை (Slash Command): நீண்ட reusable prompt அல்லது workflow-ஐ இயக்கும் குறுகிய கட்டளை.
- ஹூக் (Hook): ஆபத்தான செயல் நடக்கும் முன் நிறுத்தி சரிபார்க்கும் விதி.
- ரொட்டீன் (Routine): குறிப்பிட்ட நேரத்தில் தானாக இயங்கும் Agent வேலை.
- வெப்ஹூக் (Webhook): வெளி system-ல் event நடந்ததும் data அனுப்பப்படும் public URL endpoint.
- வொர்க்ட்ரீ (Git Worktree): அதே project-ன் இன்னொரு working folder மற்றும் வேறு branch.
- மனித மதிப்பாய்வு (Human review): Agent-ன் output-ஐ மனிதர் பார்த்து ஒப்புக்கொள்வது அல்லது திருத்துவது.
- Prompt திருத்தம் (Prompt patching): ஒவ்வொரு முறையும் prompt-ல் திருத்தம் சொல்லிக்கொண்டிருப்பது; session முடிந்ததும் மறைந்துவிடும்.
- Draft-only முறை (Draft-only mode): Agent அனுப்பவோ வெளியிடவோ கூடாது; draft மட்டும் உருவாக்க வேண்டும்.$vd$, false),
('ai-agents-tamil', 19, $vd$மேற்கோள்கள் மற்றும் ஆதாரங்கள்$vd$, $vd$மூல ஆவணத்தில் உள்ள ஆதாரங்கள் கீழே வகைப்படுத்தப்பட்டுள்ளன. முழுமையற்ற மேற்கோள்கள் குறியிடப்பட்டுள்ளன.

பொருள் ஆவணங்கள் (Product documentation)

- Claude Code Documentation – Subagents. https://code.claude.com/docs/en/sub-agents [முழுமையான மேற்கோள் தகவல் தேவை]
- Claude Agent SDK Documentation – Subagents. https://code.claude.com/docs/en/agent-sdk/subagents [முழுமையான மேற்கோள் தகவல் தேவை]

இணையதளங்கள் மற்றும் கட்டுரைகள் (Websites and articles)

- Claude Code subagents – interactive guide (allahabadi.dev). https://allahabadi.dev/blogs/ai/claude-code-subagents-interactive-guide/ [முழுமையான மேற்கோள் தகவல் தேவை]

பிற மேற்கோள்கள் (Other references)

- புத்தகத்தில் “course” மற்றும் “screenshots” எனக் குறிப்பிடப்படும் மூலப் பாடநெறி: பெயர், நடத்துபவர், தளம், ஆண்டு. [முழுமையான மேற்கோள் தகவல் தேவை]

நூல்கள் மற்றும் ஆய்வுக் கட்டுரைகள் (Books and research papers)

- மூல ஆவணத்தில் இவ்வகை மேற்கோள்கள் இல்லை.$vd$, false),
('ai-agents-tamil', 20, $vd$ஆசிரியரைப் பற்றி$vd$, $vd$P.Karthikeyan

P.Karthikeyan தற்போது Architect-ஆகப் பணியாற்றுகிறார். தகவல் தொழில்நுட்பத் துறையில் 17+ ஆண்டுகள் அனுபவம் உடையவர்.

மின்னஞ்சல்: hello@valarodigital.com

இணையதளங்கள்: valarotech.com · valarodigital.com$vd$, false),
('ai-agents-tamil', 21, $vd$நிறைவுப் பக்கம்$vd$, $vd$இந்தப் புத்தகத்தைப் படித்ததற்கு நன்றி.

அடுத்த படியாக, இந்தப் புத்தகத்தில் கற்றதைப் பயன்படுத்தி உங்கள் சொந்த முதல் Agent-ஐ உருவாக்கிப் பாருங்கள்; பிறகு சில முறை சோதித்து, Agent file-ஐ மேம்படுத்துங்கள்.

இந்தப் புத்தகம் உங்களுக்குப் பயனுள்ளதாக இருந்தால், Amazon போன்ற தளங்களில் ஒரு மதிப்புரை (review) எழுதுங்கள். உங்கள் கருத்து மற்ற வாசகர்களுக்கு உதவும்.

மேலும் தகவலுக்கு: valarotech.com · valarodigital.com$vd$, false),
('ai-agents-tamil', 22, $vd$பதிப்பகம் மற்றும் பதிப்புரிமை$vd$, $vd$செயற்கை நுண்ணறிவு Agents

தொடக்கநிலை வழிகாட்டி

A Beginner's Guide to Building and Managing AI Agents

ஆசிரியர்: P.Karthikeyan

பதிப்பகம்: Valaro Enterprises

valarotech.com  ·  valarodigital.com

முதல் பதிப்பு  ·  அக்டோபர் 2026

## பதிப்புரிமை மற்றும் பொறுப்புத் துறப்பு

பதிப்புரிமை © 2026 P.Karthikeyan. பதிப்பாளர்: Valaro Enterprises. அனைத்து உரிமைகளும் பாதுகாக்கப்பட்டவை (All rights reserved).

## கல்வி நோக்கம்

இந்தப் புத்தகம் கற்றல் நோக்கத்திற்காக எழுதப்பட்டது. இதில் உள்ள தகவல்கள் பொதுவான புரிதலுக்கானவை; குறிப்பிட்ட தொழில்முறை, சட்ட, நிதி அல்லது பாதுகாப்பு ஆலோசனைக்கு மாற்றாகாது.

## AI தகவல் குறித்த அறிவிப்பு

செயற்கை நுண்ணறிவு கருவிகளின் முடிவுகள் எப்போதும் சரியாக இருக்கும் என்று உறுதி இல்லை. AI உருவாக்கும் வெளியீடுகளை முக்கிய முடிவுகளுக்குப் பயன்படுத்தும் முன் மனிதர் சரிபார்க்க வேண்டும். இந்தப் புத்தகத்தில் உள்ள சில விளக்கப்படங்கள் AI கருவிகளால் உருவாக்கப்பட்டிருக்கலாம் [ஆசிரியர் சரிபார்க்க வேண்டும்]

## துல்லியம் மற்றும் தொழில்நுட்ப மாற்றம்

AI கருவிகளும் அவற்றின் வசதிகளும் மிக வேகமாக மாறுகின்றன. புத்தகத்தில் உள்ள கட்டளைகள், கோப்புப் பாதைகள், வசதிகள் ஆகியவை காலப்போக்கில் மாறக்கூடும். செயல்படுத்தும் முன் அதிகாரப்பூர்வ ஆவணங்களைச் சரிபார்க்கவும்.

## வர்த்தக முத்திரைகள்

இந்தப் புத்தகத்தில் குறிப்பிடப்பட்டுள்ள Claude, Claude Code உள்ளிட்ட பெயர்கள் மற்றும் பிற தயாரிப்பு, நிறுவனப் பெயர்கள் அந்தந்த உரிமையாளர்களின் வர்த்தக முத்திரைகள் ஆகும். இது ஒரு அதிகாரப்பூர்வமற்ற கற்றல் வழிகாட்டி; எந்த நிறுவனத்தின் அங்கீகாரமோ இணைப்போ இல்லை.

## வெளி இணைப்புகள்

புத்தகத்தில் உள்ள வெளி இணையதளங்களின் உள்ளடக்கத்திற்கு ஆசிரியர் பொறுப்பல்ல. அந்த இணைப்புகள் மாறலாம் அல்லது நீக்கப்படலாம்.

## அர்ப்பணிப்பு

இந்நூலை நன்கு எழுதுவதற்கான ஆற்றலையும் அறிவையும் எனக்கு அருளிய அருட்பேராற்றலுக்கு என் உளமார்ந்த நன்றியைத் தெரிவித்துக்கொள்கிறேன். அந்த அருட்பேராற்றலுக்கே இந்தப் புத்தகத்தை அன்புடன் சமர்ப்பிக்கிறேன்.$vd$, false);
