let Chat = {
  init(socket,choiceChannel) {

    console.log("dentro do chat.js");
  
    let channel = socket.channel(choiceChannel, {})
    channel.join()
    this.listenForChats(channel)
  },

  listenForChats(channel) {
    document.getElementById('chat-form').addEventListener('submit', function(e){
      e.preventDefault()

      let userName = document.getElementById('user-name').value
      let userMsg = document.getElementById('user-msg').value
      let choiceChannel= document.querySelector("#choice-channel").value;

      channel.push('shout', {name: userName, body: userMsg, school_subject: choiceChannel})

      document.getElementById('user-name').value = ''
      document.getElementById('user-msg').value = ''
    })

    channel.on('shout', payload => {
      let chatBox = document.querySelector('#chat-box')
      let msgBlock = document.createElement('p')

      msgBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)
      chatBox.appendChild(msgBlock)
    })
  }
}

export default Chat