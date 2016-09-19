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

Deploy Failure:

- I was receiving an error causing failure to Deploy
- error was reported as problem with `System.get_env(SECRET_KEY_BASE)`
- My fault...string...the env var is passed in as String such as: `System.get_env("SECRET_KEY_BASE")`
- Here was the error as reported during deploy:

    remote: -----> Fetching app dependencies with mix
    remote: ** (Mix.Config.LoadError) could not load config config/prod.secret.exs
    remote:     ** (FunctionClauseError) no function clause matching in System.get_env/1
    remote:     (elixir) lib/system.ex:267: System.get_env(SECRET_KEY_BASE)

Ecto.migrate failure:

- 

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
