<template>
<div class="Cardboxes">
    <div class="cardbox-equipe1">
      <div class="position">
        <ul>
          <li>Cycliste 1 en position (0-0)</li>
          <li>Cycliste 2 en position (0-0)</li>
          <li>Cycliste 3 en position (0-0)</li>

        </ul>
      </div>
      <div class="team">
        <h3 class="team-title">Belgique</h3>
        <div class="cards">
          <div class="card" id="cardBe1">Carte 1</div>
          <div class="card" id="cardBe2">Carte 2</div>
          <div class="card" id="cardBe3">Carte 3</div>
          <div class="card" id="cardBe4">Carte 4</div>
          <div class="card" id="cardBe5">Carte 5</div>
        </div>
      </div>
    </div>

    <div class="cardbox-equipe2">
      <div class="position">
        <ul>
          <li>Cycliste 1 en position (0-0)</li>
          <li>Cycliste 2 en position (0-0)</li>
          <li>Cycliste 3 en position (0-0)</li>

        </ul>
      </div>
      
      <div class="team">
        <h3 class="team-title">Italie</h3>
        <div class="cards">
          <div class="card" id="cardIt1">Carte 1</div>
          <div class="card" id="cardIt2">Carte 2</div>
          <div class="card" id="cardIt3">Carte 3</div>
          <div class="card" id="cardIt4">Carte 4</div>
          <div class="card" id="cardIt5">Carte 5</div>
        </div>
      </div>
    </div>

    <div class="cardbox-equipe3">
      <div class="position">
        <ul>
          <li>Cycliste 1 en position (0-0)</li>
          <li>Cycliste 2 en position (0-0)</li>
          <li>Cycliste 3 en position (0-0)</li>

        </ul>
      </div>
      <div class="team">
        <h3 class="team-title">Hollande</h3>
        <div class="cards">
          <div class="card" id="cardHo1">Carte 1</div>
          <div class="card" id="cardHo2">Carte 2</div>
          <div class="card" id="cardHo3">Carte 3</div>
          <div class="card" id="cardHo4">Carte 4</div>
          <div class="card" id="cardHo5">Carte 5</div>
        </div>
      </div>
    </div>

    <div class="cardbox-equipe4">
      <div class="position">
        <ul>
          <li>Cycliste 1 en position (0-0)</li>
          <li>Cycliste 2 en position (0-0)</li>
          <li>Cycliste 3 en position (0-0)</li>

        </ul>
      </div>
      <div class="team">
        <h3 class="team-title">Allemagne</h3>
        <div class="cards">
          <div class="card" id="cardAl1">Carte 1</div>
          <div class="card" id="cardAl2">Carte 2</div>
          <div class="card" id="cardAl3">Carte 3</div>
          <div class="card" id="cardAl4">Carte 4</div>
          <div class="card" id="cardAl5">Carte 5</div>
        </div>
      </div>
    </div>
    <button @click="scrollToTop" class="scroll-to-top">
    </button>
    <button @click="scrollToBottom" class="scroll-to-bottom">
    </button>
</div>
</template>

<script>
export default {
  name: 'CardBox',
  data() {
    return {}
  },
  methods: {
    scrollToBottom() {
      window.scrollTo({
        top: document.documentElement.scrollHeight,
        behavior: "smooth"
      });
    },
    scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: "smooth"
      });
    }
  }
}

</script>

<style scoped>

.position{
  color: rgb(255, 229, 84);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 20px;
  right: 0;
  margin-top: 50px;
}
.cardbox-equipe1 {
  width: 1000px;
  height: 220px;
  background-image: url('../assets/CardBoxBelgique.png');
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

.cardbox-equipe2 {
  width: 1000px;
  height: 220px;
  background-image: url('../assets/CardBoxItalie.png');
  background-size: cover;
  border: 10px solid black;
  border-radius: 20px;
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  bottom: 0;
  left: 0;
  margin-bottom: -215px;
  margin-left: 100px;
}

.cardbox-equipe3 {
  width: 1000px;
  height: 220px;
  background-image: url('../assets/CardBoxPaysBas.png');
  background-size: cover;
  border: 10px solid black;
  border-radius: 20px;
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  bottom: 0;
  left: 0;
  margin-bottom: -440px;
  margin-left: 100px;
}

.cardbox-equipe4 {
  width: 1000px;
  height: 220px;
  background-image: url('../assets/CardBoxAllemagne.png');
  background-size: cover;
  border: 10px solid black;
  border-radius: 20px;
  display: flex;
  flex-direction: row;
  align-items: right;
  position:absolute;
  bottom: 0;
  left: 0;
  margin-bottom: -665px;
  margin-left: 100px;
}
.team {
  margin: 10px;
  margin-left: 30px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.team-title {
  font-family: "Rockwell", serif;
  font-weight: bold;
  color: white;
  margin-top: -10px;
  margin-bottom: -10px;
}

.cards {
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin-top: 10px;
}

.card {
  width: 120px;
  height: 140px;
  background-color: rgb(234, 211, 66);
  margin: 5px;
  margin-bottom: 10px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px rgb(45, 45, 45);
  display: flex;
  justify-content: center;
  align-items: center;
}

.scroll-to-top {
  width: 80px;
  height: 80px;
  background-image: url('../assets/ButtonTop.png');
  border-radius: 10px;
  position: absolute;
  bottom: -600px;
  left: 10px;
  padding: 10px;
  font-size: 16px;
  color: #111111;
  border: none;
  cursor: pointer;
  z-index: 9999;
}

.scroll-to-bottom {
  width: 80px;
  height: 80px;
  background-image: url('../assets/ButtonBottom.png');
  border-radius: 10px;
  position: absolute;
  bottom: 150px;
  left: 10px;
  padding: 10px;
  font-size: 16px;
  color: #111111;
  border: none;
  cursor: pointer;
  z-index: 9999;
}
</style>
