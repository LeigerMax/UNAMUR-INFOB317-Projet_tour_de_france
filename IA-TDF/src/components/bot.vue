<template>
  <div class="chatbot">
    <div class="chatbox">
      
      <div class="chatbox__messages" ref="messages"></div>

      <form class="chatbox__form" @submit.prevent="handleSubmit">
        <input class="chatbox__input" id="inputChatBot" name="inputChatBot" type="text" placeholder="Votre message...">
        <button class="chatbox__button" id="submitChatBot" name="submitChatBot" type="submit">Envoyer</button>
      </form>

    </div>


  </div>

  <div class="gamebox">

  </div>
</template>

<script>
export default {
  data() {
    return {
      message: '',
    }
  },
  methods: {
    handleSubmit() {
      var inputChatBot = document.getElementById('inputChatBot');
      const message = inputChatBot.value;
      const messagesContainer_user = this.$refs.messages;
      const messageEl = document.createElement('p');
      messageEl.style.textAlign = "right";
      messageEl.style.backgroundColor = "hwb(40 7% 23% / 0.43)";
      messageEl.style.color = "white";
      messageEl.style.padding = "10px";
      messageEl.style.border = "none";
      messageEl.style.borderRadius = "5px";
      messageEl.style.margin =  "10px";
      messageEl.classList.add('user');
      messageEl.insertAdjacentHTML('beforeend', "<strong style='font-size: 18px;'>Joueur :</strong> <br/>"+ message);
      messagesContainer_user.appendChild(messageEl);

      const messagesContainer_bot = this.$refs.messages;
      const messageEl2 = document.createElement('p');
      messageEl2.style.textAlign = "left";
      messageEl2.style.backgroundColor = "#ffffff74";
      messageEl2.style.color = "white";
      messageEl2.style.padding = "10px";
      messageEl2.style.border = "none";
      messageEl2.style.borderRadius = "5px";
      messageEl2.style.margin =  "10px";
      messageEl2.classList.add('bot');
      messageEl2.insertAdjacentHTML('beforeend', "<strong style='font-size: 18px;'>TBot :</strong> <br/>"+ "Je ne suis pas connecté");
      messagesContainer_bot.appendChild(messageEl2);

      inputChatBot.value = '';
      console.log(message);

    }
  }
}
</script>



<style scoped>
.chatbot {
  text-align: left;
  padding-left: 20px;
  padding-top: 10px;
  color: rgb(255, 229, 84);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 14px;
  background-size: fill;
  width: 700px;
  height: 300px;
  background-image: url('../assets/BotChat.png');
  border: 10px solid black;
  border-radius: 25px;
  display: flex;
  flex-direction: column;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 20px;
  overflow: auto;
}

.chatbox {
  flex-grow: 1;
  /* Make chatbox fill remaining space */
}

.gamebox {
  background-size: fill;
  width: 700px;
  height: 300px;
  background-image: url('../assets/BotChat.png');
  border: 10px solid black;
  border-radius: 20px;
  display: flex;
  flex-direction: row;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 380px;
  overflow: auto;
}


.chatbox__messages {
  height: 80%;
  overflow-y: auto;
  padding: 10px;
}

.chatbox__messages p {
  display: inline-block;
  max-width: 60%;
  margin: 10px;
  padding: 10px;
  border-radius: 15px;
}

.chatbox__messages p.user {
  text-align: right;
  background-color: hwb(40 7% 23% / 0.43);
  color: white;
}

.chatbox__messages p.bot {
  text-align: left;
  background-color: #ffffff74;
  color: black;
}

.chatbox__form {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
}

.chatbox__input {
  flex: 1;
  padding: 10px;
  border: none;
  border-radius: 5px;
  font-size: 16px;
}


.chatbox__button {
  background-color: #c58a13;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
}

</style>