// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

import socket from "./socket"

import Chat from "./chat"
import Chat_second from "./chat_second"

let url_atual = window.location.href;
url_atual= url_atual.replace("http://localhost:4000").split("/")

console.log(url_atual[2])
console.log(url_atual[3])

if(url_atual[2] == url_atual[3]) 
  document.getElementById('btn').style.display = 'block';
else
  document.getElementById('btn').style.display = 'none';
  

let channel = "chat_people:" + url_atual[1] + url_atual[3]; 

Chat.init(socket, channel)

Chat_second.init(socket, "chat_people:professor")