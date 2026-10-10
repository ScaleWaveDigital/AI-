-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  command text not null check (char_length(command) <= 4000),
  status text not null default 'pending' check (status in ('pending','running','done','failed')),
  result text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.tasks enable row level security;

-- Every person can only see and create their own tasks.
create policy "tasks_select_own" on public.tasks for select using (auth.uid() = user_id);
create policy "tasks_insert_own" on public.tasks for insert with check (auth.uid() = user_id and status = 'pending');
create policy "tasks_update_own" on public.tasks for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "tasks_delete_own" on public.tasks for delete using (auth.uid() = user_id);

alter publication supabase_realtime add table public.tasks;
