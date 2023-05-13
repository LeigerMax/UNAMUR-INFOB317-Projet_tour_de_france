<template>
    <div class="map" >
      <div class="image-zoom">
        <img :src="map" alt="Carte">
      </div>
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

  .map img {
  width: 100%; /* Pour que l'image remplisse le conteneur */
  height: 100%; /* Pour que l'image remplisse le conteneur */
  object-fit: cover; /* Pour que l'image conserve son aspect ratio et remplisse le conteneur */
  transition: transform .1s;
}



</style>