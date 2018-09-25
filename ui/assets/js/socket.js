import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("results", {})

channel.on("new_result", payload => {
  console.log(payload)
  var id = `${payload.type}-${payload.address}`
  var row = document.createElement("tr")
  row.id = id
  var typeCell = document.createElement("td")
  typeCell.appendChild(document.createTextNode(payload.type))
  row.appendChild(typeCell)
  var addressCell = document.createElement("td")
  addressCell.appendChild(document.createTextNode(payload.address))
  row.appendChild(addressCell)
  var statusCell = document.createElement("td")
  statusCell.appendChild(document.createTextNode(payload.status))
  row.appendChild(statusCell)
  var timeCell = document.createElement("td")
  timeCell.appendChild(document.createTextNode(payload.time))
  row.appendChild(timeCell)
  var table = document.getElementById("results-table")
  table.appendChild(row)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
