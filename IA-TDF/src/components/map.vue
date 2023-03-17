<template>
    <div class="container">
    <img src= '../assets/carte.png' alt="Image" class="image-left">
  </div>
    <div class="chatbot">
  <img src= '../assets/BotChat.png' alt="Image" class="image-right">
  </div>
  <div class="gamebox">
  <img src= '../assets/BotChat.png' alt="Image" class="image-right">
  </div>
  <div class="cardbox">
  <img src= '../assets/CardBox.png' alt="Image" class="image-bottom">
  </div>
</template>
  
<script>
  import map from '../assets/carte.png'
  export default {
    data() {
      return {
        map : map
      };
    }
  };
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: row;
    align-items: right;
    position:absolute;
    left: 0;
    margin-left: 100px;
    margin-top: 50px;
  }

  .image-left {
    width: 1000px;
    height: 700px;
    margin-right: 30px;
    object-fit: fill;
    object-position: 50% 50%;
    border: 10px solid black;
    border-radius: 20px;
  }

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
 
.cardbox {
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  bottom: 0;
  left: 0;
  margin-bottom: -40px;
  margin-left: 100px;
}

.image-bottom {
  width: 1000px;
  height: 200px;
  margin-right: 30px;
  object-fit: cover;
  border: 10px solid black;
  border-radius: 20px;
}
</style>