<template>
  <div class="activities_game">

    <div class="chatbox_messages" ref="messages_activities"></div>

  </div>

  <div class="input_user_game">

    <button class="jouer_button" @click="jouer">Jouer </button>

    <label class="texte" id="texte_qui_joue" for="choix_cartes-select"> Joueur </label>

    <select class="combobox" name="choix_cartes-select" id="choix_cartes-select" @click="onChoixCarteSelectChange">
      <option value="" disabled selected>--Veuillez choisir une carte--</option>
      <option id="carte1" value="??">??</option>
      <option id="carte2" value="??">??</option>
      <option id="carte3" value="??">??</option>
      <option id="carte4" value="??">??</option>
      <option id="carte5" value="??">??</option>
    </select>

    <select class="combobox" name="choix_colonne" id="choix_colonne-select">
      <option value="" disabled selected>--Veuillez choisir une colonne--</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>


    <button class="deplacer_button" id="deplacer_button_dynamique" @click="deplacer_btn">Déplacer</button>


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


    <select class="combobox" name="choix_cartes-select_dev" id="choix_cartes-select-dev" @click="onChoixCarteDevSelectChange">
      <option value="" disabled selected>--Veuillez choisir une carte--</option>
      <option id="carte1" value="??">??</option>
      <option id="carte2" value="??">??</option>
      <option id="carte3" value="??">??</option>
      <option id="carte4" value="??">??</option>
      <option id="carte5" value="??">??</option>
    </select>

    <select class="combobox" name="choix_colonne" id="choix_colonne-select-dev">
      <option value="" disabled selected>--Veuillez choisir une colonne--</option>
    </select>

    <button  class="deplacer_button" id="deplacer_button_dev" @click="deplacer_btn_dev">Déplacer dev</button>

  </div>
</template>
  

<script>
import Jeu from '../components/Jeu';
import Joueur from '../components/Joueur';

export default {
  name: 'inputUser',
  data() {
    return {
      cartes: [], // Cartes du joueur
      socket: null
    }
  },
  mounted() {
   
  },
  created() {
  // Crée une seule instance de la connexion WebSocket
  this.socket = new WebSocket('ws://localhost:9999/jeu_ws'); 

  this.socket.onopen = () => {
    console.log('Connexion WebSocket établie jeu');
  };

  this.socket.onmessage = (event) => {
    const message = JSON.parse(event.data);
    // Traiter le message Prolog reçu du serveur
    this.processPrologMessage(message);
  };

  this.socket.onclose = (event) => {
    console.log('Connexion fermée avec code : ' + event.code);
  };
},
methods: {
  /************************
   *                      *
   *     WebStocket       *
   *                      *
   ***********************/

  // Méthode pour envoyer les cartes du joueur via WebSocket
  sendPlayerCards(cards, playerId) {
    if (cards && cards.length > 0) {
      // Convertir les cartes en format Prolog
      const prologCards = cards.map(card => {
        // Effectuer la conversion appropriée pour chaque carte
        // par exemple, si chaque carte est un objet avec une propriété "valeur"
        return card.valeur;
      });

      // Créer un objet contenant les informations des cartes du joueur
      const message = {
        type: "playerCards",
        playerId: playerId,
        cards: prologCards
      };

      console.log(message);
      if (this.socket.readyState === WebSocket.OPEN) {
        this.socket.send(JSON.stringify(message));
      } else {
        console.log('WebSocket connection pas ouverte.');
      }
    }
  },

  sendPlayerPlay(playerId,cyclistId, count) {
    if (this.socket.readyState === WebSocket.OPEN) {
      const message = {
        type: "playerWhoPlay",
        playerId: playerId,
        cyclistId: cyclistId, 
        count: count
      };
      this.socket.send(JSON.stringify(message));
    } else {
      console.log('WebSocket connection pas ouverte.');
    }
  },

  sendCyclistePosition(playerId, cyclistId, ligne,colonne) {
  if (this.socket.readyState === WebSocket.OPEN) {
    const message = {
      type: "cyclistePosition",
      playerId: playerId,
      cyclistId: cyclistId,
      ligne: ligne,
      colonne: colonne
    };
    this.socket.send(JSON.stringify(message));
  } else {
    console.log('WebSocket connection pas ouverte.');
  }
  },

  sendEndGame(){
    if (this.socket.readyState === WebSocket.OPEN) {
      const message = {
        type: "endGame",
      };
      this.socket.send(JSON.stringify(message));
    } else {
      console.log('WebSocket connection pas ouverte.');
    }
  },

  // Traiter le message Prolog reçu du serveur
  processPrologMessage(message) {
    if (message.type === "playerCards") {
      const playerId = message.playerId;
      const cards = message.cards;

      console.log(`Cartes du joueur ${playerId}:`, cards);


    }
    else if (message.type === "playerWhoPlay") {
      const playerId = message.playerId;
      const maxCard = message.maxCard;
      const colonne = message.colonne;
      console.log(`Joueur qui doit jouer : ${playerId}`);

   if(playerId === "Hollande" || playerId === "Allemagne") {
        console.log("BOT A JOUER");
        const choixCarteSelect = document.getElementById('choix_cartes-select');
        const choixColonneSelect = document.getElementById('choix_colonne-select');
       
        if (choixCarteSelect.options.length === 2) {
          // Si choixCarteSelect contient un seul élément, choisissez cette option
          choixCarteSelect.options[1].selected = true;
          choixColonneSelect.value = 1; // Sélectionne la colonne
        } 
        else {
          choixCarteSelect.value = maxCard; // Sélectionne la plus grande carte
          choixColonneSelect.value = colonne; // Sélectionne la colonne
        }


        var selectElement = document.getElementById("deplacer_button_dynamique");
        selectElement.style.backgroundColor = "rgb(234, 211, 66)";
        selectElement.disabled = false;

        var boutonDeplacerBot = document.querySelector('.deplacer_button');
        boutonDeplacerBot.disabled = false;
        boutonDeplacerBot.click();
    
   }
    }
    else if (message.type === "cyclistePosition") {
      const playerId = message.playerId;
      const cyclistId = message.cyclistId;
      const ligne = message.ligne;
      const colonne = message.colonne;
      console.log(`Joueur : ${playerId}, Cycliste : ${cyclistId}, (ligne : ${ligne} , colonne : ${colonne})`);
      
    }
    else if(message.type === "endGame") {
      console.log("Game finished");
    }
    else {
      console.log(`Type incorrect`);
    }
  },



    /************************
     *                      *
     *        DEV           *
     *                      *
     ***********************/

    // Lance le jeu en mode dev
    jouer_dev() {
      this.jeu = new Jeu();
      this.jeu.debut_jeu();

      // Modifie le texte du bouton
      const jeu_bouton = document.querySelector('.jouer_button');
      jeu_bouton.textContent = `Jouer`;

      const jeu_bouton_dev = document.querySelector('.jouer_button_dev');
      jeu_bouton_dev.textContent = `Rejouer dev`;


      // Affiche message activitiés
      const message = "Création du jeu pour dev <br> Création du plateau  <br> Création des joueurs  <br> Création des cyclistes  <br> Création des cartes et mélange  <br> Distribution des cartes aux joueurs";
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);


      // Bloque/Débloque inputs
      var selectElement = document.getElementById('choix_cartes-select');
      selectElement.disabled = true;
      selectElement = document.getElementById("choix_colonne-select");
      selectElement.disabled = true;
      selectElement = document.getElementById('choix_cycliste-select-dev');
      selectElement.disabled = false;
      selectElement = document.getElementById('choix_pays-select-dev');
      selectElement.disabled = false;
      selectElement = document.getElementById("choix_cartes-select-dev");
      selectElement.disabled = false;
      selectElement = document.getElementById("choix_colonne-select-dev");
      selectElement.disabled = false;
      

      var selectElementB = document.getElementById("deplacer_button_dev");
      selectElementB.style.backgroundColor = "#989795";
      selectElementB.disabled = true;


      this.init_visuel_cartes();
      this.init_visuel_positions();

       // Envoie les cartes de chaque joueur au serveur via WebSocket
      const joueurs = [this.italie, this.hollande, this.belgique, this.allemagne];
      for (const joueur of joueurs) {
        this.sendPlayerCards(joueur.cartes, joueur.nom);
      }


    },


    // Appelée lorsqu'un pays est sélectionné dans le menu déroulant. Elle appelle la méthode carte_dev().
    onChoixPaysSelectChange() {
      this.carte_dev();
    },

    // Appelée lorsqu'une carte est sélectionné dans le menu déroulant. débloque le bouton déplacer.
    onChoixCarteDevSelectChange() {
      var selectElement = document.getElementById("deplacer_button_dev");
      selectElement.style.backgroundColor = "rgb(234, 211, 66)";
      selectElement.disabled = false;
      this.nombreColonneDev();
    },


    // Met à jour l'input des cartes disponibles pour le pays sélectionné. Elle récupère toutes les cartes appartenant à ce joueur, les trie et les ajoute au menu déroulant des cartes.
    carte_dev() {
      const nom = document.getElementById('choix_pays-select-dev').value;

      // Check si nom select
      if (nom) {
        this.cartes = this.jeu.getCartes_du_joueur(nom);
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

        // Appel de la méthode sendPlayerCards avec les cartes et l'ID du joueur
        //this.sendPlayerCards(this.cartes, nom);


      }
    },

    // Défini le nombre de colonne disponible et modifie le nombre d'option de choix_colonne-select-dev.
    nombreColonneDev() {
      const nom = document.getElementById('choix_pays-select-dev').value;
      const choixCycliste = parseInt(document.getElementById('choix_cycliste-select-dev').value);
      const choixCarte = parseInt(document.getElementById('choix_cartes-select-dev').value);

      const colonneNbDisponible = this.jeu.check_colonne(nom,choixCycliste,choixCarte);

      const choixColonneSelect = document.getElementById("choix_colonne-select-dev");

      // Effacer toutes les options existantes
      while (choixColonneSelect.firstChild) {
        choixColonneSelect.removeChild(choixColonneSelect.firstChild);
      }

      // Ajouter la nouvelle option
      const defaultOption = document.createElement("option");
      defaultOption.value = "";
      defaultOption.textContent = "--Veuillez choisir une colonne--";
      defaultOption.disabled = true;
      defaultOption.selected = true;
      choixColonneSelect.appendChild(defaultOption);

      // Ajouter les options de colonne en bouclant
      for (let i = 1; i <= colonneNbDisponible; i++) {
        if(colonneNbDisponible === 4 && i === 3) continue; // ne pas créer d'option pour la colonne 3
        const option = document.createElement("option");
        option.value = i;
        option.textContent = i;
        choixColonneSelect.appendChild(option);
      }

    },

    // Déplace le cycliste
    deplacer_btn_dev() {

      this.check_fin_jeu();


      var messageReturn = "";
      const nom = document.getElementById('choix_pays-select-dev').value;
      const choixCycliste = parseInt(document.getElementById('choix_cycliste-select-dev').value);
      const choixCarte = document.getElementById('choix_cartes-select-dev').value;
      const choixColonne = document.getElementById('choix_colonne-select-dev').value;


      // Appelle la méthode deplacer_dev() de la classe Jeu
      messageReturn = this.jeu.deplacer_dev(nom, choixCycliste, choixCarte,choixColonne);

      // Récupère la position du cycliste et met à jour sur le frontend
      let positionCycliste = this.jeu.get_position_cycliste(nom, choixCycliste);
      let ligne = positionCycliste.ligne;
      let colonne = positionCycliste.colonne;
      this.visuel_position(nom, ligne,colonne, choixCycliste);

      // Affiche message activitiés
      const message = messageReturn;
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');

      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);

      this.carte_dev();

      // Bloque bouton déplacer
      var selectElement = document.getElementById("deplacer_button_dev");
      selectElement.style.backgroundColor = "#989795";
      selectElement.disabled = true;


    },


    /************************
    *                       *
    *        Dynamique      *
    *                       *
    *************************/

    // Lance le jeu en mode dynamique
    jouer() {
      this.jeu = new Jeu();
      this.jeu.debut_jeu();

      this.move_counter = 1;
      this.move_card_counter = 1;
      this.choixCycliste = 1;

      // Modifie le texte des boutons
      const jeu_bouton = document.querySelector('.jouer_button');
      jeu_bouton.textContent = `Rejouer`;

      const jeu_bouton_dev = document.querySelector('.jouer_button_dev');
      jeu_bouton_dev.textContent = `Jouer dev`;


      // Affiche message activitiés
      const message = "Création du jeu dynamique <br> Création du plateau  <br> Création des joueurs  <br> Création des cyclistes  <br> Création des cartes et mélange  <br> Distribution des cartes aux joueurs";
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);


      // Bloque/Débloque inputs
      var selectElement = document.getElementById('choix_cartes-select');
      selectElement.disabled = false;
      selectElement = document.getElementById("choix_colonne-select");
      selectElement.disabled = false;
      selectElement = document.getElementById('choix_cycliste-select-dev');
      selectElement.disabled = true;
      selectElement = document.getElementById('choix_pays-select-dev');
      selectElement.disabled = true;
      selectElement = document.getElementById("choix_cartes-select-dev");
      selectElement.disabled = true;
      selectElement = document.getElementById("choix_colonne-select-dev");
      selectElement.disabled = true;

      // Bloque bouton déplacer
      var selectElement = document.getElementById("deplacer_button_dynamique");
      selectElement.style.backgroundColor = "#989795";
      selectElement.disabled = true;

      this.init_visuel_cartes();
      this.init_visuel_positions();
      this.carte_dynamique();

      // Envoie les cartes de chaque joueur au serveur via WebSocket
      const joueurs = [
        { nom: "Italie", cartes: this.jeu.getCartes_du_joueur("Italie") },
        { nom: "Hollande", cartes: this.jeu.getCartes_du_joueur("Hollande") },
        { nom: "Belgique", cartes: this.jeu.getCartes_du_joueur("Belgique") },
        { nom: "Allemagne", cartes: this.jeu.getCartes_du_joueur("Allemagne") }
      ];

      this.sendCyclistePosition("Belgique", 1, 0, 0);
      this.sendCyclistePosition("Belgique", 2, 0, 0);
      this.sendCyclistePosition("Belgique", 3, 0, 0);

      this.sendCyclistePosition("Italie", 1, 0, 0);
      this.sendCyclistePosition("Italie", 2, 0, 0);
      this.sendCyclistePosition("Italie", 3, 0, 0);

      this.sendCyclistePosition("Hollande", 1, 0, 0);
      this.sendCyclistePosition("Hollande", 2, 0, 0);
      this.sendCyclistePosition("Hollande", 3, 0, 0);
      
      this.sendCyclistePosition("Allemagne", 1, 0, 0);
      this.sendCyclistePosition("Allemagne", 2, 0, 0);
      this.sendCyclistePosition("Allemagne", 3, 0, 0);

      for (const joueur of joueurs) {
        this.sendPlayerCards(joueur.cartes, joueur.nom);
      }



      // Envoie le joueur qui doit jouer au serveur via WebSocket
      this.sendPlayerPlay("Belgique",1, 1);

    },


    // Met à jour l'input des cartes disponibles en fonction du joueur à jouer
    carte_dynamique() {
      
      // Cherche le joueur qui doit jouer
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

      const selectElementQuiJoue = document.getElementById("texte_qui_joue");
      selectElementQuiJoue.textContent = "C'est à "+nom+" de sélectionner une carte : ";

     

      // Récupère les cartes du joueur
      this.cartes = this.jeu.getCartes_du_joueur(nom);

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

    // Appelée lorsqu'une carte est sélectionné dans le menu déroulant. débloque le bouton déplacer.
    onChoixCarteSelectChange() {
      var selectElement = document.getElementById("deplacer_button_dynamique");
      selectElement.style.backgroundColor = "rgb(234, 211, 66)";
      selectElement.disabled = false;
      this.nombreColonne();
    },

    // Défini le nombre de colonne disponible et modifie le nombre d'option de choix_colonne-select-dev.
    nombreColonne() {

      // Cherche le joueur qui doit jouer
      var nom = "";
      if (this.move_counter <= 3) {
        nom = "Belgique";
      }
      else if (this.move_counter <= 6) {
        nom = "Italie";
      }
      else if (this.move_counter <= 9) {
        nom = "Hollande";
      }
      else {
        nom = "Allemagne";
      }

      const choixCycliste = this.jeu.cycliste_qui_doit_jouer(nom);
      const choixCarte = parseInt(document.getElementById('choix_cartes-select').value);

      const colonneNbDisponible = this.jeu.check_colonne(nom,choixCycliste,choixCarte);

      const choixColonneSelect = document.getElementById("choix_colonne-select");

      // Effacer toutes les options existantes
      while (choixColonneSelect.firstChild) {
        choixColonneSelect.removeChild(choixColonneSelect.firstChild);
      }

      // Ajouter la nouvelle option
      const defaultOption = document.createElement("option");
      defaultOption.value = "";
      defaultOption.textContent = "--Veuillez choisir une colonne--";
      defaultOption.disabled = true;
      defaultOption.selected = true;
      choixColonneSelect.appendChild(defaultOption);

      // Ajouter les options de colonne en bouclant
      for (let i = 1; i <= colonneNbDisponible; i++) {
        if(colonneNbDisponible === 4 && i === 3) continue; // ne pas créer d'option pour la colonne 3
        const option = document.createElement("option");
        option.value = i;
        option.textContent = i;
        choixColonneSelect.appendChild(option);
      }

    },

    // Déplace le cycliste
    deplacer_btn() {
      var messageReturn = "";

      this.check_fin_jeu();

      // Cherche le joueur qui doit jouer
      var nom = "";
      if (this.move_counter <= 3) {
        nom = "Belgique";
      }
      else if (this.move_counter <= 6) {
        nom = "Italie";
      }
      else if (this.move_counter <= 9) {
        nom = "Hollande";
      }
      else {
        nom = "Allemagne";
      }
      this.move_counter++;

      
      const choixCarte = document.getElementById('choix_cartes-select').value;
      const choixColonne = document.getElementById('choix_colonne-select').value;
      messageReturn = this.jeu.deplacer_dynamique(nom, choixCarte,choixColonne);


      this.carte_dynamique();
      this.init_visuel_cartes();


      let positionCycliste2 = this.jeu.get_position_cycliste(nom, this.choixCycliste);
      let ligne2 = positionCycliste2.ligne;
      let colonne2 = positionCycliste2.colonne;
      console.log("TEST "+nom, this.choixCycliste, ligne2, colonne2);
      this.sendCyclistePosition(nom, this.choixCycliste, ligne2, colonne2);

      this.choixCycliste = this.jeu.cycliste_qui_doit_jouer(nom);


      for (var i = 1; i <= 3; i++) { //todo: Mettre i = 1 ?
        let positionCycliste = this.jeu.get_position_cycliste(nom, i);
        let ligne = positionCycliste.ligne;
        let colonne = positionCycliste.colonne;
        this.visuel_position(nom, ligne,colonne, i);
      }

      // Affiche message activitiés
      const message = messageReturn;
      const messagesContainer_activites = this.$refs.messages_activities;
      const messagec_ativites = document.createElement('p');
      messagec_ativites.insertAdjacentHTML('beforeend', message);
      messagesContainer_activites.appendChild(messagec_ativites);


      // Restart les compteurs
      if (this.move_counter == 13) {
        this.move_counter = 1;
      }

      if (this.move_card_counter == 13) {
        this.move_card_counter = 1;
      }

      // Bloque bouton déplacer
      var selectElement = document.getElementById("deplacer_button_dynamique");
      selectElement.style.backgroundColor = "#989795";
      selectElement.disabled = true;

      var numberCycliste;

      if (this.move_counter <= 3) {
        nom = "Belgique";
      }
      else if (this.move_counter <= 6) {
        nom = "Italie";
      }
      else if (this.move_counter <= 9) {
        nom = "Hollande";
      }
      else {
        nom = "Allemagne";
      }
      this.sendPlayerCards(this.cartes, nom);


      this.sendPlayerPlay(nom,this.choixCycliste,this.move_counter);

    },


    /************************
    *                       *
    *        Global         *
    *                       *
    *************************/

    // Initialisation des positions frontend
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

    // Modification des positions des cyclistes frondend
    visuel_position(nom, ligne,colonne, choixCycliste) {
      let liCycliste = "";
      if (nom === "Belgique") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe1 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position  (${ligne} , ${colonne})`;
        }
      }
      else if (nom === "Italie") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe2 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position  (${ligne} , ${colonne})`;
        }
      }
      else if (nom === "Hollande") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe3 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position  (${ligne} , ${colonne})`;
        }
      }
      else if (nom === "Allemagne") {
        if (choixCycliste === 1) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(1)');
          liCycliste.textContent = `Cycliste 1 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 2) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(2)');
          liCycliste.textContent = `Cycliste 2 en position  (${ligne} , ${colonne})`;
        }
        else if (choixCycliste === 3) {
          liCycliste = document.querySelector('.cardbox-equipe4 .position ul li:nth-child(3)');
          liCycliste.textContent = `Cycliste 3 en position  (${ligne} , ${colonne})`;
        }
      }


    },

    // Initialisation des cartes frontend
    init_visuel_cartes() {
      var joueurs = ["Belgique", "Italie", "Hollande", "Allemagne"];

      for (const joueur of joueurs) {
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

    // check si fin jeu
    check_fin_jeu(){
      var messageReturn = "";
      
      // Si fin du jeu
      if(this.jeu.check_fin_jeu())
      {
        this.sendEndGame();
        
        messageReturn = this.jeu.fin_jeu();

        // Bloquer les inputs
        var selectElement = document.getElementById('choix_cartes-select');
        selectElement.disabled = true;
        selectElement = document.getElementById('choix_cycliste-select-dev');
        selectElement.disabled = true;
        selectElement = document.getElementById('choix_pays-select-dev');
        selectElement.disabled = true;
        selectElement = document.getElementById("choix_cartes-select-dev");
        selectElement.disabled = true;

        // Affiche message activitiés
        const message = messageReturn;
        const messagesContainer_activites = this.$refs.messages_activities;
        const messagec_ativites = document.createElement('p');
        messagec_ativites.insertAdjacentHTML('beforeend', message);
        messagesContainer_activites.appendChild(messagec_ativites);

       

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
  overflow:auto; ;
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