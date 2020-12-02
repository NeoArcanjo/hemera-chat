let Chat_second = {
  init(socket,choiceChannel) {

    console.log("dentro do chat.js");
  
    let channel = socket.channel(choiceChannel, {})
    channel.join()
    this.listenForChats(channel)
  },

  listenForChats(channel) {
    document.getElementById('btn').addEventListener('submit', function(e){
      e.preventDefault()

      let url_atual = window.location.href;
      url_atual= url_atual.replace("http://localhost:4000").split("/")
      
      let userMsg = document.getElementById('user-msg-btn')
      
      if(url_atual[2] == url_atual[3]) {
        channel.push('shout', {name: url_atual[2], body: userMsg.value, school_type: url_atual[1] + "/"+ url_atual[3] ,prof_bool: true,remetent_prof: true})
      }
      
      userMsg.value = ''
    })

    channel.on('shout', payload => {
      let chatBox = document.querySelector('#chat_prof')
      let msgBlock = document.createElement('p')

      msgBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)
      chatBox.appendChild(msgBlock)
    })
  }
}

export default Chat_second