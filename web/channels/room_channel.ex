defmodule Slick.RoomChannel do
  use Slick.Web, :channel

  #use alias for Slick.Message from here on out. Now we can write "Message"
  alias Slick.Message

  #First join a channel
  #we don't care who is connecting right now
  #this is always called join with a
    #first is the name of the channel
    #second is any extra information about the channel
    #third is the websocket itself
  def join("rooms:" <> _room_id, _payload, socket) do

    #if implementing this as a longpolling client, here is where I would make the
    #long poll client ID and retrieve the orgs and channels

    #authenticate the user
    {:ok, socket}

  end

  #Also handle someone sending a message to a channel
  #when a user sends a message to a server send to everyone connected to channel
  #handle_in processes a message to sends
    #first is the message name
    #second is the data/payload
    #third is the web socket
  def handle_in("sendMessage", payload, socket) do

    #save to db. make blank message then save
    %Message{}
    |> Message.changeset(payload)
    |> Slick.Repo.insert

    #send this to everyone else on the channel
    #does broadcast!
    broadcast!(socket, "receiveMessage", payload)
    #tell the socket we are done
    {:noreply, socket}

  end

  #Also handle receiving a message
  #when a new message on a channel user is on, push to user
  def handle_out("receiveMessage", payload, socket) do
    #don't filter the message but if we did this is where we do it

    #send all messages filtered using push
    push(socket, "receiveMessage", payload)

    #let socket know I'm done
    {:noreply, socket}


  end

  #ORIGINAL Channel
  # def join("room:lobby", payload, socket) do
  #   if authorized?(payload) do
  #     {:ok, socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end
  #
  # # Channels can be used in a request/response fashion
  # # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end
  #
  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (room:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end
  #
  # # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
end
