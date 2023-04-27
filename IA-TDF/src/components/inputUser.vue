<template>  
  <div class="input_user_game">

    <div class="team">
      <h3>Belgique :</h3>
      <ul>
        <li>Cycliste 1 en position (0-0)</li>
        <li>Cycliste 2 en position (0-0)</li>
        <li>Cycliste 3 en position (0-0)</li>
      </ul>
    </div>
    <div class="team">
      <h3>Italie :</h3>
      <ul>
        <li>Cycliste 1 en position (0-0)</li>
        <li>Cycliste 2 en position (0-0)</li>
        <li>Cycliste 3 en position (0-0)</li>
      </ul>
    </div>
    <div class="team">
      <h3>Hollande :</h3>
      <ul>
        <li>Cycliste 1 en position (0-0)</li>
        <li>Cycliste 2 en position (0-0)</li>
        <li>Cycliste 3 en position (0-0)</li>
      </ul>
    </div>
    <div class="team">
      <h3>Allemagne :</h3>
      <ul>
        <li>Cycliste 1 en position (0-0)</li>
        <li>Cycliste 2 en position (0-0)</li>
        <li>Cycliste 3 en position (0-0)</li>
      </ul>
    </div>


    <label for="choix_cycliste-select">Choix du cycliste jouer :</label>

    <select name="choix_cycliste" id="choix_cycliste-select">
        <option value="">--Veuillez choisir un cycliste--</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
    </select>

    <label for="choix_cartes-select">Choix de la carte à jouer :</label>
    
    <select name="choix_pays" id="choix_pays-select" v-model="choix_pays"  v-on:change="onChoixPaysSelectChange">
        <option value="">--Veuillez choisir une carte--</option>
        <option value="Belgique">Belgique</option>
        <option value="Italie">Italie</option>
        <option value="Hollande">Hollande</option>
        <option value="Allemagne">Allemagne</option>
    </select>
    

    <select name="choix_cartes-select" id="choix_cartes-select">
        <option value="">--Veuillez choisir une carte--</option>
        <option id="carte1" value="??">??</option>
        <option id="carte2" value="??">??</option>
        <option id="carte3" value="??">??</option>
        <option id="carte4" value="??">??</option>
        <option id="carte5" value="??">??</option>
    </select>

    <label for="nouvelle_position">Nouvelle position :</label>
    <input id="ligne_position" type="number" min="0" max="50">
    <input id="colonne_position" type="number" min="0" max="3">

    <button @click="deplacer_btn">Déplacer</button>
    <button @click="deplacer_btn_dev">Déplacer dev</button>
    
    <button @click="jouer">Jouer</button>


  </div>
</template>
  

<script>
import Jeu from '../components/Jeu'; 
import Joueur from '../components/Joueur'; 

export default {
  name: 'inputUser',
  data() {
    return {
      cartes: [] // Cartes du joueur
    }
  },
  methods: {
    deplacer_btn() {
      // Récupérer les valeurs des inputs et les traiter ici
      
      const nom = document.getElementById('choix_pays-select').value;
      const choixCycliste = parseInt(document.getElementById('choix_cycliste-select').value);
      const choixCarte = document.getElementById('choix_cartes-select').value;
      console.log(choixCycliste);
      console.log(choixCarte);
      this.jeu.deplacer(nom, choixCycliste,choixCarte);
      this.jeu.jouer_carte_jeu(nom,choixCarte);
      this.carte();

    },
    deplacer_btn_dev() {
      // Récupérer les valeurs des inputs et les traiter ici
      
      const nom = document.getElementById('choix_pays-select').value;
      const choixCycliste = parseInt(document.getElementById('choix_cycliste-select').value);
      const choixCarte = document.getElementById('choix_cartes-select').value;
      const lignePosition = parseInt(document.getElementById('ligne_position').value);
      const colonnePosition = parseInt(document.getElementById('colonne_position').value);
      console.log(choixCycliste);
      console.log(choixCarte);
      console.log(lignePosition);
      console.log(colonnePosition);
      this.jeu.deplacer_dev(nom, choixCycliste,choixCarte, lignePosition, colonnePosition);

    },
    onChoixPaysSelectChange() {
      this.carte();
    },
    jouer() {
      this.jeu = new Jeu();
      this.jeu.debut_jeu();

      this.carte();
    },
    carte(){
      const nom = document.getElementById('choix_pays-select').value;
      console.log(nom);
      if (nom) {
        this.cartes = this.jeu.getCartes_du_joueur(nom);
        console.log(this.cartes);

        const numeros = [];

        const selectElement = document.getElementById("choix_cartes-select");
        selectElement.innerHTML = '<option value="">--Veuillez choisir une carte--</option>';
        var i = 0;
        for (const carte of this.cartes) {
          numeros.push(carte.valeur);
          console.log(numeros[i]);
          const optionElement = document.createElement("option");
          optionElement.value = numeros[i];
          optionElement.textContent = numeros[i];
          selectElement.appendChild(optionElement);
          i++;
        }
      }
    },

  }
}
</script>
  
  
  
<style scoped>
 
.input_user_game {
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
  height: 410px;
  border: 10px solid black;
  border-top-right-radius: 25px;
  border-top-left-radius: 25px;
  display: flex;
  flex-direction: column;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 500px;
  overflow: auto;
}

.team {
  margin-top: 20px;
}

.team h3 {
  margin-bottom: 5px;
}

.team ul {
  list-style-type: none;
  padding-left: 0;
  margin-left: 0;
}

.team li::before {
  content: "•";
  margin-right: 5px;
}

</style>