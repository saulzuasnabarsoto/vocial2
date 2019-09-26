defmodule Vocial2Web.Presence do
  use Phoenix.Presence,
    otp_app: :vocial2,
    pubsub_server: Vocial2.PubSub

end
