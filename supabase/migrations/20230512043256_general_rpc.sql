-- RPCS for leaderboard
--- Create type for match query results
create or replace function fetch_leaderboard(lb_type leaderboard_type DEFAULT 'ranking')
returns table(leaderboard_type leaderboard_type, player_list json)
as $$
begin
	return query
    select lb_type as leaderboard_type, json_agg(record) as player_list
    from (
      select id, lbe.account_id, lbe.value, pp.display_name, 
             pp.avatar_id, pp.avatar_url
      from leaderboardentry lbe
      inner join profiles_public pp on lbe.account_id = pp.account_id
      order by lbe.value desc -- TODO: Add more logic for ordering by lb_type
    ) record;
end;
$$ language plpgsql;

-- Set account value to leaderboard
create or replace function account_value(val int)
returns boolean
as $$
begin
    INSERT INTO leaderboardentry(account_id, value) 
    VALUES (auth.uid(), account_value.val)
    ON CONFLICT (account_id) DO UPDATE 
      SET value = account_value.val;
    return true;
exception when foreign_key_violation then
    raise exception 'Account is not found';
    return false;
end;
$$ language plpgsql;

--------------------------------------------------
-- TODO: Add more functions below before first deployment