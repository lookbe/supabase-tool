### Windows setup
#### Prerequisites
- PowerShell installed:
  - Go to the [PowerShell GitHub releases](https://github.com/PowerShell/PowerShell/releases) page and scroll down to the Assets section.
  - Click on the MSI package you want to install (e.g., PowerShell-7.2.0-win-x64.msi).
  - Once downloaded, double-click the MSI file and follow the installation prompts to complete the installation.
  - Run the command to set the execution policy to allow running scripts: `Set-ExecutionPolicy RemoteSigned`
- [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)

#### Create Supabase project from Console
- Open `app.supabase.com` to create a new project
- Store the database password somewhere securely
- Remember the project id

#### Setup Instructions
- Open PowerShell as an administrator
- Run the following command: `.\bin\setup.ps1 supabase_project_id`, replace supabase_project_id with your created project
- Get the supabase token from [here](https://app.supabase.com/account/tokens), then enter to the console where it's asking for
- Enter the database password if asked
- Change the project name in `config.toml` to match the created Supabase project name
- Make sure Docker is running
- Run project: `.\bin\start.ps1`

#### Local development instructions
- Pull the latest code from the repository
- Run the following command: `.\bin\migrate.ps1` to fetch the latest changes from supabase project
- Do git commit new files with git add and git commit if there are any new files
- Create new migration files by running: `.\bin\create.ps1 some_name` for adding new tables, functions, or altering the previous migrations.  WARNING: Take a look at notes below before creating a new migration
- Apply new changes: `.\bin\apply.ps1`

*Note*:
- Supabase CLI cannot detect changes from existing migrations files which have been deployed to Supabase before, so once we deployed the migrations, we should not edit or add new things into them, instead, just create a new migration and add there. Not a good way but it's a downside of Supabase Cli.
- Supabase migration supports creating a new migration with the same name as existing files, the timestamp will be generated automatically, so we can use the name corresponding to one of 3 games: **intlchess**, **chinesschess** and **3gull** in order to add/edit table/functions related to the game.
- We can specify the schema for any function or table in the migration by adding the prefix before the name as examples: intlchess.table_name, intlchess.function_name, chinesschess.table_name, chinesschess.function_name, etc.

#### Manual Deployment
- Run the following command to deploy: `.\bin\deploy.ps1`

#### CI/CD Develop Deployment Instructions with Github Actions
- Commit and push changes to the repository
- Create a Pull Request to `develop` branch
- A github action job will be triggered off to test the pull request
- If successful, merge the pull request
- Another job will get started to deploy changes to the supabase project for dev environment

#### CI/CD Production Deployment Instructions with Github Actions
- Create a Pull Request from `develop` branch to `main` branch
- Do merge if the test job succeeded
- A job will be started to deploy to the production supabase project

#### Database unit testing
- All test cases will be placed at the path: `tests/database`
- Adding more test files by just creating new files with format: `table_name.test.sql`
- Run the command: `./bin/test-run.ps1` to run all tests
- Following the [unit Testing](https://supabase.com/docs/guides/database/extensions/pgtap) and [documentation](https://pgtap.org/) to add more tests

#### Client usage
- Install Supabase SDK
- Initialize the client with Supabase App URL and ANON key, specifying Schema as well
  - For ex:
  ```
    const intlChessClient = createClient(
      'SP_URL', 'ANON_KEY', {
        schema: 'intlchess'
      }
    )
  ```
  - We can create multiple clients with different Schema
  - Using corresponding client for querying Supabase database

Note: The tables/functions have not been specified the schema when getting created with prefix: `schema_name.table_name` or `schema_name.function_name`, it will be assigned to the default schema: **public**