# Daily Ledger

A single-file, dependency-free daily task tracker: recurring habits, per-day tasks with
priority and notes, streaks, a 7-day completion chart and an 18-week consistency heatmap.

- \`index.html\` — the whole site. Open it directly, or host it anywhere static.
- \`supabase-setup.sql\` — the one table + policies the sync needs.

## Deploying to GitHub Pages

1. Create a public repo (e.g. daily-ledger) and put index.html at its root.
2. Repo **Settings → Pages → Build and deployment → Deploy from a branch**, branch main, folder / (root).
3. After a minute the site is live at https://<your-username>.github.io/daily-ledger/

No build step, no bundler — pushing a new index.html is the deploy.

## Turning on cross-device sync

1. Create a free project at supabase.com.
2. Open the project's **SQL Editor**, paste supabase-setup.sql, press Run.
3. In **Project Settings → API**, copy the **Project URL** and the **anon public** key.
4. On the live site, click **Sync settings** at the bottom of the task panel and paste both,
   plus a **ledger name** of your choosing.
5. Enter the same three values on every device you use.

The anon key is designed to sit in public client code. The ledger name is what separates
your rows, so treat it like a password — anyone who knows it (and the project URL) can read
and write that ledger. This is the trade-off of a site with no login.

To bake the values into the page so new devices need no setup, replace the three
__SUPABASE_URL__ / __SUPABASE_ANON_KEY__ / __LEDGER_SPACE__ placeholders near the top
of the script block in index.html and redeploy. Anyone who visits the site then shares
that ledger, so only do this if the URL stays private to you.

## Without any of that

The page works offline out of the box: everything is written to localStorage, and
**Export** / **Import** move a JSON snapshot between devices by hand.

## How the data is shaped

Days are keyed by date; each day carries a modified stamp used to merge across devices.
Merging is per-day last-write-wins, so two devices editing different days never clobber
each other; for the same day, the later write wins.
