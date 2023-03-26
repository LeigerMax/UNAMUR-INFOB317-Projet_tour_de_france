<template>
  <div class="cardbox">
    <div class="team">
      <h3 class="team-title">Equipe 1</h3>
      <div class="cards">
        <div class="card">Carte 1</div>
        <div class="card">Carte 2</div>
        <div class="card">Carte 3</div>
        <div class="card">Carte 4</div>
        <div class="card">Carte 5</div>
      </div>
    </div>
    <div class="team">
      <h3 class="team-title">Equipe 2</h3>
      <div class="cards">
        <div class="card">Carte 1</div>
        <div class="card">Carte 2</div>
        <div class="card">Carte 3</div>
        <div class="card">Carte 4</div>
        <div class="card">Carte 5</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CardBox',
  data() {
    return {}
  },
}
</script>

<style scoped>
.cardbox {
  width: 1000px;
  height: 220px;
  background-image: url('../assets/CardBox.png');
  background-size: cover;
  border: 10px solid black;
  border-radius: 20px;
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  bottom: 0;
  left: 0;
  margin-bottom: 10px;
  margin-left: 100px;
}

.team {
  margin: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.team-title {
  color: white;
  margin-bottom: 10px;
}

.cards {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

.card {
  width: 80px;
  height: 100px;
  background-color: rgb(238, 196, 69);
  margin: 5px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px grey;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
