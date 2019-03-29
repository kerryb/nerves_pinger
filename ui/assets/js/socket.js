import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let info_channel = socket.channel("info", {})

info_channel.on("message", payload => {
  var flash = document.getElementById("flash-info")
  flash.textContent = payload.message
})

info_channel.on("clear", payload => {
  var flash = document.getElementById("flash-info")
  flash.textContent = ""
})

info_channel.join()
  .receive("ok", resp => { console.log("Joined info channel", resp) })
  .receive("error", resp => { console.log("Unable to join info channel", resp) })

export default socket
