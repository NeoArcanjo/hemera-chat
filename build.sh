#! /usr/bin/env bash

mix deps.get --only prod
MIX_ENV=prod mix compile

npm install --prefix ./assets
npm rum deploy --prefix ./assets
mix phx.digest

rm -rf "_build"
MIX_ENV=prod mix release



Release created at _build/prod/rel/chat_vue!

    # To start your system
    _build/prod/rel/chat_vue/bin/chat_vue start

Once the release is running:

    # To connect to it remotely
    _build/prod/rel/chat_vue/bin/chat_vue remote

    # To stop it gracefully (you may also send SIGINT/SIGTERM)
    _build/prod/rel/chat_vue/bin/chat_vue stop

To list all commands:

    _build/prod/rel/chat_vue/bin/chat_vue