# Desktop Agent

A Claude-powered agent that lives in a small always-on-top window on your PC. You can type tasks into it, attach files, or send tasks from a website. People can create accounts on the website, and each person's tasks go only to their own signed-in agent.

```
web/index.html  --(tasks table, Supabase)-->  agent/ (Electron app on your PC)  --> Claude API + tools
```

## Setup (about 15 minutes)

1. **Supabase:** create a project. In the SQL Editor, run `supabase/schema.sql`.
2. **Auth:** Authentication > Providers: email is on by default. For Google, follow Supabase's Google provider page. Under URL Configuration, add your website address (for example `https://USERNAME.github.io/REPO/`).
3. **Website:** open `web/index.html`, check that `SUPABASE_URL` and `SUPABASE_ANON_KEY` match your project (already filled in). Host the `web` folder with GitHub Pages (Settings > Pages).
4. **Agent app:** install Node.js, then in `agent/`:
   ```
   copy .env.example .env      (Mac/Linux: cp)
   npm install
   npm start
   ```
   Fill `.env` with your Anthropic API key and the same Supabase URL and anon key. Sign in inside the agent window with the account you made on the website.
5. **GitHub:** `git init`, `git add .`, `git commit -m "agent"`, then push. `.env` is git-ignored, so your keys stay on your PC.

## Using it
- **Ctrl+Shift+Space** hides or shows the window. **Ctrl+Shift+X** stops the agent immediately.
- Drag files onto the window to attach them (images, PDFs, text and code files).
- **Screen control** is off by default. Turn the checkbox on and the agent can see your screen and use the mouse and keyboard.
- Writing files and running commands always ask you first. The agent is told to confirm before sending messages or deleting anything.

## Security notes
- The agent signs in as you, so Supabase row-level security means a task can only come from your own account.
- Never put your Anthropic API key in the website or in GitHub.
- Anything the agent reads (files, web pages, chats) is treated as data, but no agent is immune to trickery. Keep Screen control off when you don't need it.
- Screen control works with logged-in apps, but WhatsApp's terms ban automation. For your 400-number list, run small batches (the agent pauses a random 15 to 90 seconds between items), use a spare number if you can, and have it write a status column to the sheet before deleting any rows.

## Not built yet
- Direct Google Sheets API connection (right now it uses your screen or code), GitHub API tools (it can use `git` through commands), Roblox Studio via Rojo, and Google sign-in inside the desktop window.
- First run needs testing on your PC. Screen coordinates on high-DPI displays may need adjusting.
