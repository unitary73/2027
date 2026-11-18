-- 원광 캠퍼스 마당: 광장 게시판 표
-- Supabase > SQL Editor 에 통째로 붙여 넣고 Run 을 누른다. 한 번만 실행하면 된다.
-- (예전 "한 사람 한 장" 표를 이미 만들었다면 이 파일 대신 아래쪽 "옮기기" 부분만 실행한다)

create table if not exists public.notes (
  id    uuid primary key default gen_random_uuid(),  -- 포스트잇마다 새 번호. 한 사람이 여러 장 붙일 수 있다
  owner uuid not null default auth.uid(),            -- 붙인 사람(익명 로그인한 사람의 id)
  t  text not null check (char_length(t) between 1 and 60
                          and t !~ '[0-9]{2,4}[- .]?[0-9]{3,4}[- .]?[0-9]{4}'),   -- 글(60자), 전화번호 꼴은 거절
  c  smallint not null default 0 check (c between 0 and 4),   -- 종이 색
  f  smallint not null default 0 check (f between 0 and 3),   -- 글씨체
  n  text not null check (char_length(n) between 1 and 10),   -- 마당에서 쓰는 이름
  at bigint not null                                          -- 붙인 시각(ms)
);
create index if not exists notes_owner_idx on public.notes (owner);

alter table public.notes enable row level security;

-- 읽기는 누구나, 붙이기·떼기는 자기 글만
-- auth.uid() 를 (select ...) 로 감싸야 줄마다 다시 계산하지 않는다 (Supabase 성능 경고 대응)
-- 익명 로그인 사용자도 authenticated 역할이라 글을 쓸 수 있다. 보안 경고 "Anonymous Sign-Ins Allowed" 는 의도된 것
create policy "notes read all"   on public.notes for select to anon, authenticated using (true);
create policy "notes insert own" on public.notes for insert to authenticated with check ((select auth.uid()) = owner);
create policy "notes update own" on public.notes for update to authenticated using ((select auth.uid()) = owner) with check ((select auth.uid()) = owner);
create policy "notes delete own" on public.notes for delete to authenticated using ((select auth.uid()) = owner);

-- 새 글이 붙으면 열려 있는 화면에 바로 보이게 한다
alter publication supabase_realtime add table public.notes;


-- ───────── 옮기기: 예전 "한 사람 한 장" 표 → 여러 장 표 (이미 만든 프로젝트에서 한 번만) ─────────
-- 예전 표는 id 가 곧 붙인 사람이었다. 그 값을 owner 로 옮기고, 새 글부터는 번호를 따로 만든다.
-- alter table public.notes add column if not exists owner uuid;
-- update public.notes set owner = id where owner is null;
-- alter table public.notes alter column owner set default auth.uid();
-- alter table public.notes alter column owner set not null;
-- alter table public.notes alter column id set default gen_random_uuid();
-- create index if not exists notes_owner_idx on public.notes (owner);
-- alter policy "notes insert own" on public.notes with check ((select auth.uid()) = owner);
-- alter policy "notes update own" on public.notes using ((select auth.uid()) = owner) with check ((select auth.uid()) = owner);
-- alter policy "notes delete own" on public.notes using ((select auth.uid()) = owner);
