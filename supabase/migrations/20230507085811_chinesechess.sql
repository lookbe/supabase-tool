do $$ begin
    create schema chinesschess;
exception
    when duplicate_object then null;
end $$;

GRANT USAGE 
ON SCHEMA chinesschess 
TO postgres, anon, authenticated, service_role, dashboard_user;

GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA chinesschess 
TO postgres, authenticated, service_role, dashboard_user, anon;

-- For gathering all database functionalities of chinesschess game
----------------------------------------------------------------
create or replace function chinesschess.recordmatchresult()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

----------------------------------------------------------------
create or replace function chinesschess.updateleaderboard()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

--------------------------------------------------------------
-- TODO: Add more functions below before first deployment