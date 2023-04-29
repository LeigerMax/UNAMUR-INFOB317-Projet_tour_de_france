<template>
  <div class="activities_game">

    <div class="chatbox_messages_question" ref="messages_activities"></div>

  </div>

  <div class="input_user_game">

    <button class="jouer_button" @click="jouer">Jouer </button>

    <label class="texte" for="choix_cartes-select">Choix de la carte à jouer :</label>

    <select class="combobox" name="choix_cartes-select" id="choix_cartes-select">
      <option value="" disabled selected>--Veuillez choisir une carte--</option>
      <option id="carte1" value="??">??</option>
      <option id="carte2" value="??">??</option>
      <option id="carte3" value="??">??</option>
      <option id="carte4" value="??">??</option>
      <option id="carte5" value="??">??</option>
    </select>



    <button class="deplacer_button" @click="deplacer_btn">Déplacer</button>


    <button class="jouer_button_dev" @click="jouer_dev">Jouer dev</button>


    <select class="combobox" name="choix_cycliste-dev" id="choix_cycliste-select-dev">
      <option value="" disabled selected>--Veuillez choisir un cycliste--</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>

    <select class="combobox" name="choix_pays-dev" id="choix_pays-select-dev" v-model="choix_pays"
      v-on:change="onChoixPaysSelectChange">
      <option value="" disabled selected>--Veuillez choisir un pays--</option>
      <option value="Belgique">Belgique</option>
      <option value="Italie">Italie</option>
      <option value="Hollande">Hollande</option>
      <option value="Allemagne">Allemagne</option>
    </select>


    <select class="combobox" name="choix_cartes-select_dev" id="choix_cartes-select-dev">
      <option value="" disabled selected>--Veuillez choisir une carte--</option>
      <option id="carte1" value="??">??</option>
      <option id="carte2" value="??">??</option>
      <option id="carte3" value="??">??</option>
      <option id="carte4" value="??">??</option>
      <option id="carte5" value="??">??</option>
    </select>


    <button class="deplacer_button" @click="deplacer_btn_dev">Déplacer dev</button>

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

    /************************
     *                      *
     *        DEV           *
     *                      *
     ***********************/
    jouer_dev() {
      const dev = true;
      this.jeu = new Jeu();
      this.jeu.debut_jeu(dev);

      var jeu_bouton = document.querySelector('.jouer_button_dev');
      jeu_bouton.textContent = `Rejouer dev`;

      this.init_visuel_cartes();

      const message = "Création du jeu pour dev <br> Création du plateau  <br> Création des joueurs  <br> Création des cyclistes  <br> Création des cartes et mélange  <br> Distribution des cartes aux joueurs";

      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);

      this.init_visuel_positions();

      // Bloque/Débloque inputs
      var selectElement = document.getElementById('choix_cartes-select');
      selectElement.disabled = true;
      selectElement = document.getElementById('choix_cycliste-select-dev');
      selectElement.disabled = false;
      selectElement = document.getElementById('choix_pays-select-dev');
      selectElement.disabled = false;
      selectElement = document.getElementById("choix_cartes-select-dev");
      selectElement.disabled = false;

    },


    onChoixPaysSelectChange() {
      this.carte_dev();
    },

    carte_dev() {
      const nom = document.getElementById('choix_pays-select-dev').value;
      if (nom) {
        this.cartes = this.jeu.getCartes_du_joueur(nom);
        console.log(this.cartes);

        const numeros = [];

        const selectElement = document.getElementById("choix_cartes-select-dev");
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
        this.init_visuel_cartes();
      }
    },


    deplacer_btn_dev() {
      var messageReturn;
      const nom = document.getElementById('choix_pays-select-dev').value;
      const choixCycliste = parseInt(document.getElementById('choix_cycliste-select-dev').value);
      const choixCarte = document.getElementById('choix_cartes-select-dev').value;

      messageReturn = this.jeu.deplacer_dev(nom, choixCycliste, choixCarte);
      this.carte_dev();
     
      let positionCycliste = this.jeu.get_position_cycliste(nom, choixCycliste);

      this.visuel_position(nom, positionCycliste, choixCycliste);

      // Affiche message activitiés
      const message = messageReturn;
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);

    },


    /************************
    *                       *
    *        Dynamique      *
    *                       *
    *************************/
    jouer() {
      const dev = false;
      this.jeu = new Jeu();
      this.jeu.debut_jeu(dev);

      this.move_counter = 1;
      this.move_card_counter = 1;

      var jeu_bouton = document.querySelector('.jouer_button');
      jeu_bouton.textContent = `Rejouer`;

      this.init_visuel_cartes();

      const message = "Création du jeu dynamique <br> Création du plateau  <br> Création des joueurs  <br> Création des cyclistes  <br> Création des cartes et mélange  <br> Distribution des cartes aux joueurs";

      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);

      this.init_visuel_positions();

      // Bloque/Débloque inputs
      var selectElement = document.getElementById('choix_cartes-select');
      selectElement.disabled = false;
      selectElement = document.getElementById('choix_cycliste-select-dev');
      selectElement.disabled = true;
      selectElement = document.getElementById('choix_pays-select-dev');
      selectElement.disabled = true;
      selectElement = document.getElementById("choix_cartes-select-dev");
      selectElement.disabled = true;

      this.carte_dynamique();


    },


    carte_dynamique() {
      var nom = "";
      if (this.move_card_counter <= 3) {
        this.move_card_counter++;
        nom = "Belgique";
      }
      else if (this.move_card_counter <= 6) {
        this.move_card_counter++;
        nom = "Italie";
      }
      else if (this.move_card_counter <= 9) {
        this.move_card_counter++;
        nom = "Hollande";
      }
      else {
        this.move_card_counter++;
        nom = "Allemagne";
      }


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
      this.init_visuel_cartes();

    },


    deplacer_btn() {
      var nom = "";
      if (this.move_counter <= 3) {
        this.move_counter++;
        nom = "Belgique";
      }
      else if (this.move_counter <= 6) {
        this.move_counter++;
        nom = "Italie";
      }
      else if (this.move_counter <= 9) {
        this.move_counter++;
        nom = "Hollande";
      }
      else {
        this.move_counter++;
        nom = "Allemagne";
      }


      const choixCarte = document.getElementById('choix_cartes-select').value;
      const messageReturn = this.jeu.deplacer_dynamique(nom, choixCarte);
      this.carte_dynamique();
      this.init_visuel_cartes();


      for (var i = 0; i <= 3; i++) {
        let positionCycliste = this.jeu.get_position_cycliste(nom, i);
        this.visuel_position(nom, positionCycliste, i);
      }

      // Affiche message activitiés
      const message = messageReturn;
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);
      

      // Restart compteur
      if (this.move_counter == 13) {
        this.move_counter = 1;
      }

      if (this.move_card_counter == 13) {
        this.move_card_counter = 1;
      }

    },




    /************************
    *                       *
    *        Global         *
    *                       *
    *************************/
    init_visuel_positions() {
      const positionCycliste = "0-0";
      let liCycliste;
      let liCycliste2;
      let liCycliste3;
      liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(1)');
      liCycliste2 = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(2)');
      liCycliste3 = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(3)');
      liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
      liCycliste2.textContent = `Cycliste 2 en position (${positionCycliste})`;
      liCycliste3.textContent = `Cycliste 3 en position (${positionCycliste})`;
      liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(1)');
      liCycliste2 = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(2)');
      liCycliste3 = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(3)');
      liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
      liCycliste2.textContent = `Cycliste 2 en position (${positionCycliste})`;
      liCycliste3.textContent = `Cycliste 3 en position (${positionCycliste})`;
      liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(1)');
      liCycliste2 = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(2)');
      liCycliste3 = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(3)');
      liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
      liCycliste2.textContent = `Cycliste 2 en position (${positionCycliste})`;
      liCycliste3.textContent = `Cycliste 3 en position (${positionCycliste})`;
      liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(1)');
      liCycliste2 = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(2)');
      liCycliste3 = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(3)');
      liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
      liCycliste2.textContent = `Cycliste 2 en position (${positionCycliste})`;
      liCycliste3.textContent = `Cycliste 3 en position (${positionCycliste})`;
    },

    visuel_position(nom, positionCycliste, choixCycliste) {
      let liCycliste = "";
      if (nom === "Belgique") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position (${positionCycliste})`;
        }
      }
      else if (nom === "Italie") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position (${positionCycliste})`;
        }
      }
      else if (nom === "Hollande") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position (${positionCycliste})`;
        }
      }
      else if (nom === "Allemagne") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position (${positionCycliste})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position (${positionCycliste})`;
        }
      }

     
    },


    init_visuel_cartes() {
      this.joueurs = ["Belgique", "Italie", "Hollande", "Allemagne"];

      for (const joueur of this.joueurs) {
        const cartesDuJoueur = this.jeu.getCartes_du_joueur(joueur);

        const numeros = [];

        const cardElements = document.querySelectorAll(".card"); // get all card elements
        let i = 0;
        for (const carte of cartesDuJoueur) {
          numeros.push(carte.valeur);

          // set card visu
          const id = "card" + joueur.substring(0, 2) + (i + 1); // gérer le cas où le joueur a une carte de moins
          const cardElement = document.getElementById(id);
          cardElement.textContent = numeros[i];

          i++;
        }

        // gérer le cas où le joueur a une carte de moins
        if (i < 5) {
          const id = "card" + joueur.substring(0, 2) + (i + 1); // gérer le cas où le joueur a une carte de moins
          const cardElement = document.getElementById(id);
          cardElement.textContent = "?";
          i++;
        }
      }
    },


  }
}
</script>
  
  
  
<style scoped>
.activities_game {
  background-size: left;
  padding-left: 20px;
  padding-top: 10px;
  padding-bottom: 10px;
  color: rgb(255, 229, 84);
  font-family: "Calibri", "Copperplate", fantasy;
  font-size: 16px;
  background-image: url('../assets/BotChat.png');
  background-size: fill;
  width: 700px;
  height: 210px;
  border: 10px solid black;
  border-radius: 25px;
  display: flex;
  flex-direction: column;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 350px;
  overflow: auto;
}

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
  height: 335px;
  border: 10px solid black;
  border-radius: 25px;
  display: flex;
  flex-direction: column;
  align-items: right;
  position: fixed;
  right: 0;
  margin-right: 40px;
  margin-top: 580px;
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

.jouer_button,
.jouer_button_dev {
  background-color: rgb(234, 211, 66);
  color: rgb(10, 10, 10);
  border: none;
  border-radius: 5px;
  padding: 8px;
  font-size: 16px;
  cursor: pointer;
  margin: 10px;
}

.jouer_button:hover,
.jouer_button_dev:hover {
  background-color: rgb(221, 168, 22);
  transition: color 0.5s, background-color 0.5s;
}

.deplacer_button {
  background-color: rgb(234, 211, 66);
  color: rgb(10, 10, 10);
  border: none;
  border-radius: 5px;
  padding: 8px;
  font-size: 16px;
  cursor: pointer;
  margin: 10px;
}

.deplacer_button:hover {
  background-color: rgb(221, 168, 22);
  transition: color 0.5s, background-color 0.5s;
}

.combobox {
  background-color: #ffffffff;
  padding: 8px;
  border-radius: 5px;
  margin: 10px;
}

.texte {
  font-size: 16px;
}
</style>