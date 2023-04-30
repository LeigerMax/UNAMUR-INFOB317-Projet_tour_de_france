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
  <form class="chatbot_game_form" @submit.prevent="handleSubmit({ type: 'game' })">
    <input class="chatbot_game_input" id="chatbot_game_input" name="chatbot_game_input" type="text" placeholder="Donner une directive ...">
    <button class="chatbot_game_button" id="chatbot_game_submit" name="chatbot_game_submit" type="submit">Envoyer</button>
  </form>
</template>

<script>
export default {
  data() {
    return {
      socket: null,
      message: '',
      messages: [],
    }
  },
  mounted() {
    this.socket = new WebSocket('ws://localhost:9999/ws');
    this.socket.onopen = () => {
      this.connectionStatus = 'Connected';
    };
    this.socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      this.messages.push(message);
    };
    this.socket.onclose = () => {
      this.connectionStatus = 'Disconnected';
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

        // Reponse bot
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
        messageBot.insertAdjacentHTML('beforeend', " <strong style='font-size: 18px;'>TBot :</strong> <br/>" + "Je ne suis pas connecté"); // J'ai tenter de mettre des balises <div class='chatbox__messages_bot'>
        messagesContainer_bot.appendChild(messageBot);

        chatbot_question_input.value = '';
        console.log(message);

        const sendMessage = {
          content: this.message,
        };
        console.log(this.socket);
        console.log(this.message);
        console.log(sendMessage);
        console.log(JSON.stringify(sendMessage));
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
  color: rgb(255, 229, 84);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 14px;
  background-image: url('../assets/BotChat.png');
  background-size: fill;
  width: 700px;
  height: 390px;
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
  margin-top: 390px;
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
  background-color: #c58a13;
  color: white;
  border: none;
  border-bottom-right-radius: 5px;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
}

/* CHATBOT GAME */

.chatbot_game {
  background-size: left;
  padding-left: 20px;
  padding-top: 10px;
  padding-bottom: 10px;
  color: rgb(255, 229, 84);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 14px;
  background-image: url('../assets/BotChat.png');
  background-size: fill;
  width: 700px;
  height: 390px;
  border: 10px solid black;
  border-top-right-radius: 25px;
  border-top-left-radius: 25px;
  display: flex;
  flex-direction: column-reverse;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 500px;
  overflow: auto;
}

.chatbot_game_form {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 880px;
  width: 700px;
}

.chatbot_game_input {
  flex: 1;
  padding: 10px;
  border: none;
  border-bottom-left-radius: 5px;
  font-size: 16px;
}

.chatbot_game_button {
  background-color: #c58a13;
  color: white;
  border: none;
  border-bottom-right-radius: 5px;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
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