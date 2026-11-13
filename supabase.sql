-- 원광 캠퍼스 마당: 광장 게시판 표
-- Supabase > SQL Editor 에 통째로 붙여 넣고 Run 을 누른다. 한 번만 실행하면 된다.

create table if not exists public.notes (
  id uuid primary key default auth.uid(),          -- 익명 로그인한 사람의 id. 한 사람이 한 장
  t  text not null check (char_length(t) between 1 and 60
                          and t !~ '[0-9]{2,4}[- .]?[0-9]{3,4}[- .]?[0-9]{4}'),   -- 글(60자), 전화번호 꼴은 거절
  c  smallint not null default 0 check (c between 0 and 4),   -- 종이 색
  f  smallint not null default 0 check (f between 0 and 3),   -- 글씨체
  n  text not null check (char_length(n) between 1 and 10),   -- 마당에서 쓰는 이름
  at bigint not null                                          -- 붙인 시각(ms)
);

alter table public.notes enable row level security;

-- 읽기는 누구나, 쓰기·고치기·떼기는 자기 글만
create policy "notes read all"   on public.notes for select to anon, authenticated using (true);
create policy "notes insert own" on public.notes for insert to authenticated with check (auth.uid() = id);
create policy "notes update own" on public.notes for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);
create policy "notes delete own" on public.notes for delete to authenticated using (auth.uid() = id);

-- 새 글이 붙으면 열려 있는 화면에 바로 보이게 한다
alter publication supabase_realtime add table public.notes;
