create table if not exists public.beats (
  id text primary key,
  title text not null,
  genre text not null,
  bpm integer not null check (bpm > 0),
  key text not null,
  price numeric(10, 2) not null check (price >= 0),
  tag text not null default '',
  art integer not null default 1 check (art between 1 and 8),
  created_at timestamptz not null default now()
);

alter table public.beats enable row level security;
grant select on public.beats to anon, authenticated;

drop policy if exists "Beats are publicly readable" on public.beats;
create policy "Beats are publicly readable"
  on public.beats for select
  to anon, authenticated
  using (true);

insert into public.beats (id, title, genre, bpm, key, price, tag, art) values
  ('midnight-run', 'Midnight Run', 'Trap', 142, 'F#m', 29, 'Chwa semèn nan', 1),
  ('blue-hour', 'Blue Hour', 'R&B', 88, 'C#m', 24, 'Smooth', 2),
  ('solèy-leve', 'Solèy Leve', 'Afro', 106, 'Am', 29, 'Afro vibe', 3),
  ('no-signal', 'No Signal', 'Drill', 145, 'Gm', 34, 'New drop', 4),
  ('komèt', 'Komèt', 'Afro', 112, 'D#m', 25, 'Afro fusion', 5),
  ('after-hours', 'After Hours', 'R&B', 92, 'Bm', 24, 'Late night', 6),
  ('tonbe-pa-tonbe', 'Tonbe Pa Tonbe', 'Trap', 138, 'Em', 29, 'Hard', 7),
  ('lakou', 'Lakou', 'Drill', 140, 'C#m', 34, 'Dark energy', 8)
on conflict (id) do nothing;
