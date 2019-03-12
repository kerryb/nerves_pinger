import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let results_channel = socket.channel("results", {})
let info_channel = socket.channel("info", {})

function createCell(text) {
  var cell = document.createElement("td")
  cell.appendChild(document.createTextNode(text))
  return cell
}

results_channel.on("new_result", payload => {
  var id = `${payload.type}-${payload.address}`
  var row = document.createElement("tr")
  row.id = id
  row.appendChild(createCell(payload.type))
  row.appendChild(createCell(payload.address))
  row.appendChild(createCell(payload.timestamp))
  row.appendChild(createCell(payload.status))
  row.appendChild(createCell(payload.time))
  var existingRow = document.getElementById(id)
  if (existingRow === null) {
    document.querySelector("tbody").appendChild(row)
  } else {
    existingRow.parentNode.replaceChild(row, existingRow)
  }
})

info_channel.on("message", payload => {
  var flash = document.getElementById("flash-info")
  flash.textContent = payload.message
})

info_channel.on("clear", payload => {
  var flash = document.getElementById("flash-info")
  flash.textContent = ""
})

results_channel.join()
  .receive("ok", resp => { console.log("Joined results channel", resp) })
  .receive("error", resp => { console.log("Unable to join results channel", resp) })

info_channel.join()
  .receive("ok", resp => { console.log("Joined info channel", resp) })
  .receive("error", resp => { console.log("Unable to join info channel", resp) })

export default socket
