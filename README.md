# Slick

Messaging app from Rik's Elixir Basics class from Superhi.

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Notes

Config of prod environment through heroku using env variables.
Replicate env variables across the pipeline

###Deploy Failure:

- I was receiving an error causing failure to Deploy
- error was reported as problem with `System.get_env(SECRET_KEY_BASE)`
- My fault...string...the env var is passed in as String such as: `System.get_env("SECRET_KEY_BASE")`
- Here was the error as reported during deploy:

    remote: -----> Fetching app dependencies with mix
    remote: ** (Mix.Config.LoadError) could not load config config/prod.secret.exs
    remote:     ** (FunctionClauseError) no function clause matching in System.get_env/1
    remote:     (elixir) lib/system.ex:267: System.get_env(SECRET_KEY_BASE)

###`Ecto.migrate` failure:

- Here the problem is that heroku hobby-dev tier for postgres has a 20 connections limit
- The default prod DB settings for ecto is 20.
- So the `mix ecto.migrate` command fails as no connections are available for the task to run
- This error looked as such:

    [error] Postgrex.Protocol (#PID<0.160.0>) failed to connect: ** (Postgrex.Error) FATAL (too_many_connections): too many connections for role "xxxxxxx"
    (DBConnection.ConnectionError) connection not available because of disconnection

###WebSocket failure

- In local dev, localhost is the url. In heroku, there is an actual URL. There is some origin check on wss connection that fails.
- Adding config to `config/prod.exs` under `My_App.Endpoint` as `check_origin: ["//elixir-app*.herokuapp.com"]`
- Here are the errors:  

    CLIENT ERROR in browser
    app-033ad8e….js?vsn=d:1 WebSocket connection to 'wss://elixir-app-dev.herokuapp.com/socket/websocket?vsn=1.0.0' failed: Error during WebSocket handshake: Unexpected response code: 403

    SERVER ERROR in Elixir console:
    2016-09-19T12:02:30.119507+00:00 heroku[router]: at=info method=GET path="/socket/websocket?vsn=1.0.0" host=elixir-app-dev.herokuapp.com request_id=af585d39-bdfc-4322-b27c-db14cddfd724 fwd="62.17.146.144" dyno=web.1 connect=0ms service=1ms status=403 bytes=150
    2016-09-19T12:02:43.388827+00:00 app[web.1]: 12:02:43.388 [error] Could not check origin for Phoenix.Socket transport.
    2016-09-19T12:02:43.388843+00:00 app[web.1]:
    2016-09-19T12:02:43.388844+00:00 app[web.1]: This happens when you are attempting a socket connection to
    2016-09-19T12:02:43.388845+00:00 app[web.1]: a different host than the one configured in your config/
    2016-09-19T12:02:43.388845+00:00 app[web.1]: files. For example, in development the host is configured
    2016-09-19T12:02:43.388845+00:00 app[web.1]: to "localhost" but you may be trying to access it from
    2016-09-19T12:02:43.388846+00:00 app[web.1]: "127.0.0.1". To fix this issue, you may either:
    2016-09-19T12:02:43.388847+00:00 app[web.1]:
    2016-09-19T12:02:43.388847+00:00 app[web.1]:   1. update [url: [host: ...]] to your actual host in the
    2016-09-19T12:02:43.388848+00:00 app[web.1]:      config file for your current environment (recommended)
    2016-09-19T12:02:43.388848+00:00 app[web.1]:
    2016-09-19T12:02:43.388848+00:00 app[web.1]:   2. pass the :check_origin option when configuring your
    2016-09-19T12:02:43.388849+00:00 app[web.1]:      endpoint or when configuring the transport in your
    2016-09-19T12:02:43.388849+00:00 app[web.1]:      UserSocket module, explicitly outlining which origins
    2016-09-19T12:02:43.388850+00:00 app[web.1]:      are allowed:
    2016-09-19T12:02:43.388851+00:00 app[web.1]:
    2016-09-19T12:02:43.388851+00:00 app[web.1]:         check_origin: ["https://example.com",
    2016-09-19T12:02:43.388851+00:00 app[web.1]:                        "//another.com:888", "//other.com"]
    2016-09-19T12:02:43.388852+00:00 app[web.1]:

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
