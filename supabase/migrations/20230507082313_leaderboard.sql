-- Tables creation
create table if not exists leaderboardentry (
    id bigserial primary key,
    account_id uuid not null,
    constraint fk_users foreign key(account_id) references auth.users(id) on delete cascade,
    value int default 0,
    unique(account_id)
);

do $$ begin
    create type leaderboard_type as enum ('richest', 'ranking');
exception
    when duplicate_object then null;
end $$;

-- RLS definitions
alter table leaderboardentry enable row level security;
create policy "Authorized users can see leaderboardentry" on leaderboardentry for select
to authenticated using (true);
