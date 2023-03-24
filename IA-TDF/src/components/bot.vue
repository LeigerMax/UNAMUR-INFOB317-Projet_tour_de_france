<template>
    <div class="chatbot">
      <p>BOT : WESH MA COUILLE C'EST MOI LE BOT</p>
      
  </div>
    <div class="gamebox">
  </div>
</template>

<script>
import chat from '../assets/BotChat.png'
export default {
  data() {
    return {
      chat : chat
    };
  }
};
</script>

<style scoped>
  .chatbot {
    text-align: left;
    padding-left: 20px;
    padding-top: 10px;
    color: rgb(255, 229, 84);
    font-family: "Copperplate", fantasy;
    font-size: 30px;
    background-size: fill;
    width: 700px;
    height: 300px;
    background-image: url('../assets/BotChat.png');
    border: 10px solid black;
    border-radius: 25px;
    display: flex;
    flex-direction: row;
    align-items: right;
    position:fixed;
    right: 0;
    margin-right: 40px;
    margin-top: 20px;
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
    position:fixed;
    right: 0;
    margin-right: 40px;
    margin-top: 380px;
}


</style>