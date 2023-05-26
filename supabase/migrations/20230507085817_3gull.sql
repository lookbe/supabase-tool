do $$ begin
    create schema threegull;
exception
    when duplicate_object then null;
end $$;

GRANT USAGE 
ON SCHEMA threegull 
TO postgres, anon, authenticated, service_role, dashboard_user;

GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA threegull 
TO postgres, authenticated, service_role, dashboard_user, anon;

-- For gathering all database functionalities of 3gull game

----------------------------------------------------------------
create or replace function threegull.recordmatchresult()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

---------------------------------------------------------------
create or replace function threegull.updateleaderboard()
returns boolean
as $$
begin
    -- TODO: Add logics here
    return true;
end;
$$ language plpgsql;

---------------------------------------------------------------
-- TODO: Add more functions below before first deployment