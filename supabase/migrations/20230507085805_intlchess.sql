do $$ begin
    create schema intlchess;
exception
    when duplicate_object then null;
end $$;

GRANT USAGE 
ON SCHEMA intlchess 
TO postgres, anon, authenticated, service_role, dashboard_user;

GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA intlchess 
TO postgres, authenticated, service_role, dashboard_user, anon;

-- For gathering all database functionalities of intlchess game
----------------------------------------------------------------
create or replace function intlchess.updateleaderboard()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

----------------------------------------------------------------
create or replace function intlchess.recordmatchresult()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

----------------------------------------------------------------
-- TODO: Add more functions below before first deployment