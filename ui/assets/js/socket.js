import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("results", {})

function createCell(text) {
  var cell = document.createElement("td")
  cell.appendChild(document.createTextNode(text))
  return cell
}

channel.on("new_result", payload => {
  console.log(payload);
  var id = `${payload.type}-${payload.address}`
  var row = document.createElement("tr")
  row.id = id
  row.appendChild(createCell(payload.type))
  row.appendChild(createCell(payload.address))
  row.appendChild(createCell(payload.status))
  row.appendChild(createCell(payload.time))
  var existingRow = document.getElementById(id)
  if (existingRow === null) {
    document.querySelector("tbody").appendChild(row)
  } else {
    existingRow.parentNode.replaceChild(row, existingRow)
  }
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
