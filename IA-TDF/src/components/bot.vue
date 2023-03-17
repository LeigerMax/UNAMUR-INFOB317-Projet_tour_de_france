<template>
    <div class="chatbot">
  <img src= '../assets/BotChat.png' alt="Image" class="image-right">
  </div>
    <div class="gamebox">
  <img src= '../assets/BotChat.png' alt="Image" class="image-right">
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
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  right: 0;
  margin-right: 40px;
  margin-top: 50px;
}

.gamebox {
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  right: 0;
  margin-right: 40px;
  margin-top: 530px;
}

.image-right {
  width: 600px;
  height: 450px;
  margin-right: 30px;
  object-fit: cover;
  object-position: 50% 50%;
  border: 10px solid black;
  border-radius: 20px;
}
</style>