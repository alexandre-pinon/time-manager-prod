defmodule TimeManagerAPI.Auth.Token do
  use Joken.Config

  def token_config, do: default_claims(default_exp: 60 * 60 * 24) # 1 day
end
