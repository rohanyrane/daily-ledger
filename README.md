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

## Cross-device sync

Already wired up. The Supabase project URL and publishable key are baked into
`index.html`, so on a new device you only do this once:

1. Open the site and click **Sync settings** at the bottom of the task panel.
2. Type your **ledger name** into the third field. Leave the other two alone.
3. Save. The ledger loads from Supabase and keeps syncing from then on.

The ledger name is the only thing separating your rows, so treat it like a
password — anyone who knows it can read and write that ledger. The publishable
key is safe in public code; row-level security is on and there is no delete policy.

Schema lives in `supabase-setup.sql` (table `public.ledger`).

## Without any of that

The page works offline out of the box: everything is written to localStorage, and
**Export** / **Import** move a JSON snapshot between devices by hand.

## How the data is shaped

Days are keyed by date; each day carries a modified stamp used to merge across devices.
Merging is per-day last-write-wins, so two devices editing different days never clobber
each other; for the same day, the later write wins.
