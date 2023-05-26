begin;
select plan(1);

-- Verify that the table exists
select has_table('leaderboard');

-- Verify that the table has value column
select has_column('leaderboard', 'value');
select col_is_pk('leaderboard', 'id'); -- test that id column is a primary key

select * from finish();
rollback;