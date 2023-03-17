<template>
  <div class="cardbox">
  <img src= '../assets/CardBox.png' alt="Image" class="image-bottom">
  </div>
</template>

<script>

</script>

<style scoped>
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