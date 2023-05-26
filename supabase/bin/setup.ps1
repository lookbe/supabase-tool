# Install Node.js and npm
Invoke-WebRequest -Uri https://nodejs.org/dist/v16.13.0/node-v16.13.0-x64.msi -OutFile node.msi
Start-Process msiexec.exe -Wait -ArgumentList '/i node.msi /quiet /norestart'

# Install the Supabase CLI
npm install -g supabase-cli

# Link supabase project
supabase login
supabase link --project-ref args[0]