import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})

// Finally, connect to the socket:
socket.connect()

export default socket
