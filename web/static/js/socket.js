import {Socket} from "phoenix"

/*
how does it know how to connect to the server, what is the URL/endpoint?
*/

//this must be an endpoint autodefined by phoenix for websocket connections?
let socket = new Socket("/socket")
//connect to the endpoint?
socket.connect()

let chatInput   = $(".chat-input")
let messages    = $(".messages")
let room_id     = chatInput.data("roomId")

//setup channel name information
let channel = socket.channel("rooms:" + room_id, {})

//attach event handler for keypress
//attach to the chatInput element (this is the textarea)
//on enter (keyCode 13, I guess) take the chatinput value and the room_id and
//push it to the channel
//trigger the sendMessage event the (handle_in behaviour pattern matches on this)
chatInput.on("keypress", event => {
  if (event.keyCode === 13){
    channel.push("sendMessage", {
      body: chatInput.val(),
      room_id: room_id
    })
    //clear the field
    chatInput.val("")
    //don't allow the default behavior of the event?
    event.preventDefault()
  }
})

//must be a websocket event. handle the event pass in the message
//and append some stuff to the list of messages 
channel.on("receiveMessage", message => {
  messages.append(`<p>${message.body}</p>`)
})

//join a channel?
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
