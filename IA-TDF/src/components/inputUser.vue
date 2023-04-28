<template>
  <div class="activities_game">

    <div class="chatbox_messages_question" ref="messages_activities"></div>

  </div>

  <div class="input_user_game">

    <button class="jouer_button" @click="jouer">Jouer</button>

    <label class="texte" for="choix_cycliste-select">Choix du cycliste jouer :</label>

    <select class="combobox" name="choix_cycliste" id="choix_cycliste-select">
      <option value="" disabled selected>--Veuillez choisir un cycliste--</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>

    <label class="texte" for="choix_cartes-select">Choix de la carte à jouer :</label>

    <select class="combobox" name="choix_pays" id="choix_pays-select" v-model="choix_pays"
      v-on:change="onChoixPaysSelectChange">
      <option value="" disabled selected>--Veuillez choisir un pays--</option>
      <option value="Belgique">Belgique</option>
      <option value="Italie">Italie</option>
      <option value="Hollande">Hollande</option>
      <option value="Allemagne">Allemagne</option>
    </select>


    <select class="combobox" name="choix_cartes-select" id="choix_cartes-select">
      <option value="" disabled selected>--Veuillez choisir une carte--</option>
      <option id="carte1" value="??">??</option>
      <option id="carte2" value="??">??</option>
      <option id="carte3" value="??">??</option>
      <option id="carte4" value="??">??</option>
      <option id="carte5" value="??">??</option>
    </select>

    <button class="deplacer_button" @click="deplacer_btn">Déplacer</button>
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
      const messageReturn = this.jeu.deplacer(nom, choixCycliste, choixCarte);
      this.jeu.jouer_carte_jeu(nom, choixCarte);
      this.carte();

      let positionCycliste = this.jeu.get_position_cycliste(nom, choixCycliste);
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

      const message = messageReturn;
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);



    },
    onChoixPaysSelectChange() {
      this.carte();
    },
    jouer() {
      this.jeu = new Jeu();
      this.jeu.debut_jeu();

      var jeu_bouton = document.querySelector('.jouer_button');
      jeu_bouton.textContent = `Rejouer`;

      this.carte2();

      const message = "Création du jeu <br> Création du plateau  <br> Création des joueurs  <br> Création des cyclistes  <br> Création des cartes et mélange  <br> Distribution des cartes aux joueurs";

      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);


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
    carte() {
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
        this.carte2();
      }
    },
    carte2() {
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
    }
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

.jouer_button {
  background-color: rgb(234, 211, 66);
  color: rgb(10, 10, 10);
  border: none;
  border-radius: 5px;
  padding: 8px;
  font-size: 16px;
  cursor: pointer;
  margin: 10px;
}

.jouer_button:hover {
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