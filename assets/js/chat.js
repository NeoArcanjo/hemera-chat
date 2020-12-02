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

      let remetent_prof = false;
      let url_atual = window.location.href;
      url_atual= url_atual.replace("http://localhost:4000").split("/")

      let userName = url_atual[2]
      
      let userMsg = document.getElementById('user-msg').value

      if(url_atual[2] == url_atual[3])
        remetent_prof = true

      
      channel.push('shout', {name: userName, body: userMsg, school_type: url_atual[1] + "/"+ url_atual[3], prof_bool: false, remetent_prof: remetent_prof})

      document.getElementById('user-msg').value = ''
    })

    channel.on('shout', payload => {
      let chatBox = document.querySelector('#chat-box')
      let msgBlock = document.createElement('p')


      let url_atual = window.location.href;
      url_atual= url_atual.replace("http://localhost:4000").split("/")
      

      if(payload.name == url_atual[3]) 
        msgBlock.insertAdjacentHTML('beforeend', `<b style="color: blue">${payload.name}:</b> ${payload.body}`)
      else
        msgBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)

      chatBox.appendChild(msgBlock)
    })
  }
}

export default Chat