<template>
  <div class="chatbot_question">
    <div class="chatbox_question">
      <div class="chatbox_messages_question" ref="messages_question"></div>
    </div>
  </div>
  <form class="chatbot_question_form"  @submit.prevent="handleSubmit({ type: 'question' })">
    <input class="chatbot_question_input" id="chatbot_question_input" name="chatbot_question_input" type="text" v-model="message" placeholder="Votre question...">
    <button class="chatbot_question_button" id="chatbot_question_submit" name="chatbot_question_submit" type="submit">Envoyer</button>
  </form>

  <div class="chatbot_game">
    <div class="chatbox_game">
      <div class="chatbox_messages_game" ref="messages_game"></div>
    </div>
  </div>

</template>

<script>
export default {
  data() {
    return {
      socket: null,
      message: '',
      messageBack: [],
    }
  },
  mounted() {
    this.socket = new WebSocket('ws://localhost:9999/ws');
    this.socket.onopen = () => {
      this.connectionStatus = 'Connexion WebSocket établie chat';
      console.log('Connexion WebSocket établie chat');
    };
    this.socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      this.messageBack.push(message);
      const messagesContainer_bot = this.$refs.messages_question;
      const messageBot = document.createElement('p');
      messageBot.style.textAlign = "left";
      messageBot.style.backgroundColor = "#ffffff74";
      messageBot.style.color = "white";
      messageBot.style.padding = "10px";
      messageBot.style.border = "none";
      messageBot.style.borderRadius = "5px";
      messageBot.style.margin = "10px";
      messageBot.style.wordWrap = "break-word";
      //messageBot.classList.toggle('chatbox_messages_user');
      messageBot.insertAdjacentHTML('beforeend', " <strong style='font-size: 18px;'>TBot :</strong> <br/>" + this.messageBack.toString().replaceAll(",", " ").replaceAll(" '", "'").replaceAll(" .", ".")); // J'ai tenter de mettre des balises <div class='chatbox__messages_bot'>
      messagesContainer_bot.appendChild(messageBot);
      this.messageBack.pop();
    };
    this.socket.onclose = () => {
      this.connectionStatus = 'Connexion WebSocket fermée chat';
      console.log('Connexion WebSocket fermée chat');
    };
  },
  methods: {
    handleSubmit(form) {
      if (form.type === 'question') { //Si form question

        // Input user
        var inputChatBot = document.getElementById('chatbot_question_input');
        const message = inputChatBot.value;
        const messagesContainer_user = this.$refs.messages_question;
        const messageUser = document.createElement('p');
        messageUser.style.textAlign = "right";
        messageUser.style.backgroundColor = "rgba(255, 229, 84, 0.375)";
        messageUser.style.color = "white";
        messageUser.style.padding = "10px";
        messageUser.style.border = "none";
        messageUser.style.borderRadius = "5px";
        messageUser.style.margin = "10px";
        messageUser.style.wordWrap = "break-word";
        //messageUser.classList.add('chatbox_messages_user');
        messageUser.insertAdjacentHTML('beforeend', "<strong style='font-size: 18px;'>Joueur :</strong> <br/>" + message);
        messagesContainer_user.appendChild(messageUser);

        chatbot_question_input.value = '';

        var messToProlog =  this.message;
        const sendMessage = {
          content: messToProlog,
        };
        console.log(sendMessage);
        this.socket.send(JSON.stringify(sendMessage));
        this.message = '';

      }
      else { //Si form game 

        // Input user
        var inputChatBot = document.getElementById('chatbot_game_input');
        const message = inputChatBot.value;
        const messagesContainer_user = this.$refs.messages_game;
        const messageUser = document.createElement('p');
        messageUser.style.textAlign = "right";
        messageUser.style.backgroundColor = "rgba(255, 229, 84, 0.375)";
        messageUser.style.color = "white";
        messageUser.style.padding = "10px";
        messageUser.style.border = "none";
        messageUser.style.borderRadius = "5px";
        messageUser.style.margin = "10px";
        messageUser.style.wordWrap = "break-word";
        //messageUser.classList.add('chatbox_messages_user');
        messageUser.insertAdjacentHTML('beforeend', "<strong style='font-size: 18px;'>Joueur :</strong> <br/>" + message);
        messagesContainer_user.appendChild(messageUser);

        // Reponse bot
        const messagesContainer_bot = this.$refs.messages_game;
        const messageBot = document.createElement('p');
        messageBot.style.textAlign = "left";
        messageBot.style.backgroundColor = "#ffffff74";
        messageBot.style.color = "white";
        messageBot.style.padding = "10px";
        messageBot.style.border = "none";
        messageBot.style.borderRadius = "5px";
        messageBot.style.margin = "10px";
        messageBot.style.wordWrap = "break-word";
        //messageBot.classList.toggle('chatbox_messages_user');
        messageBot.insertAdjacentHTML('beforeend', " <strong style='font-size: 18px;'>TBot :</strong> <br/>" + "Je ne suis pas connecté"); // J'ai tenter de mettre des balises <div class='chatbox__messages_bot'>
        messagesContainer_bot.appendChild(messageBot);

        chatbot_game_input.value = '';
        console.log(message);
      }
    },

    

  }
}
</script>



<style scoped>
/* CHATBOT QUESTION */
.chatbot_question {
  text-align: left;
  padding-left: 20px;
  padding-top: 10px;
  padding-bottom: 10px;
  color: rgb(234, 211, 66);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 14px;
  background-image: url('../assets/BotChat.png');
  background-size: fill;
  width: 700px;
  height: 250px;
  border: 10px solid black;
  border-top-right-radius: 25px;
  border-top-left-radius: 25px;
  display: flex;
  flex-direction: column-reverse;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 20px;
  overflow: auto;
}

.chatbot_question_form {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 260px;
  width: 700px;
}

.chatbot_question_input {
  flex: 1;
  padding: 10px;
  border: none;
  border-bottom-left-radius: 5px;
  font-size: 16px;
}


.chatbot_question_button {
  background-color: rgb(234, 211, 66);
  color: rgb(10, 10, 10);
  border: none;
  border-bottom-right-radius: 5px;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
}

.chatbot_question_button:hover {
  background-color: rgb(221, 168, 22);
  transition: color 0.5s, background-color 0.5s;
}

/* CHATBOX */

.chatbox_messages_user {
  text-align: "right";
  background-color: "hwb(40 7% 23% / 0.43)";
  color: "white";
  padding: "10px";
  border: "none";
  border-radius: "5px";
  margin: "10px";
  /*wordWrap: break-word;*/
}


.chatbox_messages_bot {
  text-align: left;
  background-color: #ffffff74;
  color: white;
  padding: 10px;
  border: none;
  border-radius: 5px;
  margin: 10px;
  /*wordWrap: break-word;*/
}
</style>