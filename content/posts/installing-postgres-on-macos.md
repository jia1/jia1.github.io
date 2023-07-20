---
title: "Installing Postgres on macOS"
date: 2023-07-20T23:09:00+08:00
draft: false
tags: ["postgres"]
---
Before this, the last time I installed a Postgres database on my local machine was years ago. I wished I found [Sami Korpela's blog post](https://samikorpela.dev/posts/pg-on-macos-2023/) sooner. It had everything I needed:

```bash
# macOS Ventura Terminal

brew install postgresql@15
echo 'export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
brew services start postgresql
createuser -s postgres
psql postgres # or psql -U your_username -d your_database

### postgres=# ###

\l # List databases
\du # List roles
\c your_database # Connect to database
\c your_database other_username # Connect to database as other_username
\d # List relations (tables)
```
