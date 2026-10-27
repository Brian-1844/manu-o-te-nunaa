# Manu o te nūnaʻa — handover kit (state of 27 Oct 2026)

French-language educational web game: the player governs **Motu Nui, an imaginary Pacific island**. Single-file HTML/Canvas game, painted "living gouache" style.

- Live site (GitHub Pages): https://brian-1844.github.io/manu-o-te-nunaa/  — repo `brian-1844/manu-o-te-nunaa` (Brian uploads the web zip himself).
- Claude artifact of the game: https://claude.ai/artifact/Bt64fPm8NfS6zQu63iUUbQ (version 31). Republish by passing this URL.
- Owner: Brian (Tahiti). Talks in English/French; game texts are French.

## Restore in a new session
1. Unzip the kit, run `bash restore.sh` (copies files to /tmp and /home/claude, installs fonts, builds, validates).
2. Output: `/home/claude/motu-nui/motu-nui.html` (the game) and `/tmp/g.js` (extracted script, checked with `node --check`).

## Build pipeline
- `build.py` assembles `motu-nui.base.html` (CSS, Scene module = painted island, hero) + `content/*.js` (events, cards, easy texts, lexicon) + segments from `/tmp`:
  `seg1, seg2` → `seg_assets, seg_cabinet, seg_crises, seg_living, seg_p5` → `seg3` → `seg_p6 … seg_p11, seg_p13, seg_p14, seg_p15, seg_p16, seg_p17, seg_p18 (+kids.json, lex_kids.json), seg_p19, seg_p12 (+general.json)` and extra CSS `/tmp/p9.css`.
- **Hook pattern:** later segments wrap global functions: `const base = window.fn; window.fn = function(){…base…}` and `VIEWS.x` wrappers for screens. Buttons use `data-pNN` attributes bound in a `window.bind` wrapper.
- Scene API: `Scene.update/addTrauma/freeze/renderHero/brush/highlight/posOf/size/flagPos`.
- **Text layers swapped at runtime (path → text):**
  - `general.json` (seg_p12): default = imaginary island; setting « Contexte local : Polynésie française » (`PREFS.localCtx`) restores the original Polynesian texts. `LOC(general, local)` helper for code strings.
  - `kids.json` + `lex_kids.json` (seg_p18): simple texts for 9–12 y/o, active when `easyOn()` (fun mode, or Éducation « Collège »).
- Web package: `/home/claude/manu-mana-web/` (index.html rebuilt from the game; keep head before `<title>` and the service-worker tail). **Bump `sw.js` cache** (now `manu-mana-v27` → next `v28`), then zip to `/home/claude/manu-o-te-nunaa-web.zip`. Check with `node /tmp/webcheck.js`.

## Tests (all must stay clean)
`node /tmp/validate.js` · `node /tmp/easycheck.js` · `node /tmp/sim.js` (balance) · `node /tmp/webcheck.js` · playthroughs in `/tmp/p11/`: `play.js`, `play4.js` (local ctx), `funroute.js` (fun mode), `serious.js`, `kidtest.js`, `ctx.js`, `opp.js`, `fest.js`, `q.js`, `modes.js`.

## Features (phases)
Base game (budget, events, Assembly 40 seats with real-style rules, crises, cyclone, censure, ministers, public assets, class mode, teacher guide, quizzes, lexicon) + recent work:
- p11 **brush**: each decision paints a touch on the island (21 community scenes, zoom + brush), « Revoir le coup de pinceau ».
- p12 **imaginary island** + optional local context.
- p13 **tappable island**: neighbourhood sheets (6 groups), « Quartiers » button.
- p14 **festivals** (one per year, 3 choices) + **Manu the bird guide** (one-time tips).
- p15 **custom president** (Femme/Homme/Autre → Président·e, inclusive forms), **quick game** (2 years), **badges collection** (localStorage), **final painting** to download/share, warmer radio + letter follow-ups.
- p16 **three modes**: Pour s'amuser (quick, easy text, 3 challenge levels), Jeu sérieux (8 years, full detail), Éducation (class, age levels Collège/Lycée/Adultes, local-context switch).
- p17 **L'arbre de l'île**: painted tree medallion = island health (8 stages).
- p18 **children's texts** (1,458 rewritten) + children's lexicon.
- p19 **debate & opposition**: « Écouter l'avis de l'opposition » on every decision (+1 Démocratie, vote help), event `g_debat` with Mareva (opposition leader), card « Le débat et l'opposition », badge « Ouvert au débat ».

## Standing rules from Brian (important)
- Fictional first names only, never real family names; **no mention of recent real people**.
- Be respectful: **no mockery** of anyone; humour must be kind. Opposition is never an "enemy".
- Keep the game **general (imaginary Pacific island)**; Polynesia only as labelled real examples in « Comprendre » cards or in local-context mode.
- Music/sound: **low treble** (high pitch is hard on his ears).
- Living-painting art direction (gouache), Pacific culture kept.

## Promo assets (in /home/claude/promo)
Facebook cover/avatar, 24 s intro video, 66 s YouTube video `manu-o-te-nunaa-presentation-youtube.mp4` + `miniature-youtube.jpg`. Scripts: `/tmp/promo` (stills.js, video.js, music.py, soundtrack.py, promo_lib.js; Brian's nature recordings in `/tmp/promo/rec`) and `/tmp/yt` (shots.js → video.js → ffmpeg with soundtrack.wav).

## Open items / ideas
- Playtest with 4–5 teenagers (watch 15 min, ask: liked / bored / play again?) and adjust text amount.
- Not done yet: year-end time-lapse of the island; bigger island view on phones; toʻere rhythm mini-game at festivals; class leaderboard/duel screen.
- To verify: some generalised "why" texts make broad claims (see general.json); kids rewrite dropped details (Romania execution, seaside plant names naupata/tahinu/miki miki, importers warning in « riz » quote).
- Download/share of the final painting works on the website, not inside the Claude artifact viewer.
