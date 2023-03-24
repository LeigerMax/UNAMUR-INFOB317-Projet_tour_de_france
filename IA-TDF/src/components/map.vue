<template>
    <div class="map">
  </div>
  <div class="cardbox">
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
  .map {
    background-size: cover;
    width: 1000px;
    height: 660px;
    background-image: url('../assets/carte.png');
    border: 10px solid black;
    border-radius: 20px;
    display: flex;
    flex-direction: row;
    align-items: right;
    position:fixed;
    left: 0;
    margin-left: 100px;
    margin-top: 20px;
  }
</style>