import Joueur from './Joueur';
import Cycliste from './Cycliste';
import Carte from './Carte';
import Plateau from './Plateau';
import InputUser from './InputUser.vue';

class Jeu {
  constructor() {
    this.cartes = [];
    this.cartesDepot = [];
    this.plateau = new Plateau();
    this.joueursList = [];
    this.currentCyclisteIndex = 1; // initialisé à 1 pour le premier cycliste
    this.historiquePositionCycliste = [];
    this.premierTour = 0;
    this.tour = 0;
    this.cycliste_chute = [];
    this.cyclistes_finis = [];
  }

  /**
   * Initialise le jeu en initialisant les joueurs, les cartes, en les mélangeant et en distribuant les cartes aux joueurs.
   */
  debut_jeu() {
    console.log("Lancement");
    this.init_joueurs();
    this.init_cartes();
    this.melanger_cartes(this.cartes);
    this.distribuer_cartes_debut_jeu();
    this.afficher_nombre_cartes_restantes();
  }

  check_colonne(nom, choixCycliste, choixCarte) {
    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
        console.log("Joueur non trouvé.");
        break;
    }

    var positionInitLigne = parseInt(this.joueur.getCyclisteTest(choixCycliste).position.getLigne());
    var positionInitColonne = parseInt(this.joueur.getCyclisteTest(choixCycliste).position.getColonne());
    var positionApres = positionInitLigne + choixCarte;
    var colonneNbDisponible;
    if((positionInitLigne >= 24 && positionInitLigne <= 39) && (positionApres <= 39)) {
      colonneNbDisponible = this.plateau.getNbColonnesCircuit12(positionApres,positionInitColonne); 
    }
    else if((positionInitLigne >= 89 && positionInitLigne <= 102) && (positionApres <= 102)) {
      colonneNbDisponible = 1; 
    }
    else {
      colonneNbDisponible = this.plateau.getNbColonnes(positionApres);
    }
    //console.log("Position init : " + positionInitLigne);
    //console.log("Position après : " + positionApres);
    //console.log("Colonne disponible : " + colonneNbDisponible);

    return colonneNbDisponible;
  }

  /******************************
  *                             *
  *            Joueur           *
  *                             *
  *******************************/


  /**
   * Initialise les joueurs et leurs cyclistes pour le jeu.
   * Les joueurs créés sont la Belgique, l'Italie, la Hollande et l'Allemagne.
   * Chaque joueur a trois cyclistes avec un identifiant unique et un nom de code spécifique à leur pays.
   */
  init_joueurs() {
    // Création des joueurs
    this.belgique = new Joueur("Belgique");
    this.italie = new Joueur("Italie");
    this.hollande = new Joueur("Hollande");
    this.allemagne = new Joueur("Allemagne");

    this.joueursList.push(this.belgique);
    this.joueursList.push(this.italie);
    this.joueursList.push(this.hollande);
    this.joueursList.push(this.allemagne);

    //console.log("LIST : ", this.joueursList);

    // Création des cyclistes pour chaque joueur
    for (let i = 1; i <= 3; i++) {
      this.belgique.ajouter_cycliste(new Cycliste(i, "be" + i));
      this.italie.ajouter_cycliste(new Cycliste(i, "it" + i));
      this.hollande.ajouter_cycliste(new Cycliste(i, "ho" + i));
      this.allemagne.ajouter_cycliste(new Cycliste(i, "al" + i));
    }

    // Affichage des joueurs avec leurs cyclistes
   //console.log("Belgique : ", this.belgique);
   //console.log("Italie : ", this.italie);
   //console.log("Hollande : ", this.hollande);
   //console.log("Allemagne : ", this.allemagne);
  }




  /******************************
  *                             *
  *            Cycliste         *
  *                             *
  *******************************/

  /**
   * DEV : Permet de faire dépalcer un cycliste.
   * 
   * @param {string} nom du joueur
   * @param {number} choixCycliste numéro du cycliste
   * @param {number} choixCarte numéro de la carte
   * @returns {string} Une chaine de character contenant les informations sur le déplacement du cycliste.
   */
  deplacer_dev(nom, choixCycliste, choixCarte, choixColonne) {
    //console.log("DEV : Dépalacer");
    var messageReturn;

    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
       // console.log("Joueur non trouvé.");
        break;
    }

    // Récupère les positions de tout les cyclistes de chaque joueur
    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();



    // Check si joueur à fini la course ou non
    // Si pas fini, appel la méthode deplacer_cycliste() et joue la carte.
    if (!this.cycliste_fin_course(this.joueur, choixCycliste)) {
      messageReturn = this.joueur.deplacer_cycliste(choixCycliste, choixCarte, choixColonne, this.plateau, this.cycliste_chute, this.cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      this.jouer_carte_jeu(this.joueur, choixCarte);
    }
    // Si fini, vérifie que le cycliste se trouve dans la liste cyclistes_finis, sinon l'ajoute dedans.
    else {
      messageReturn = "Le cycliste a déjà atteint la ligne d'arrivé";
      //console.log(messageReturn);
      //Si liste vide ajoute le cycliste 
      if (this.cyclistes_finis.length === 0) {
        this.cyclistes_finis.push(this.joueur.getCyclisteTest(choixCycliste));
      }
      for (var i = 0; i < this.cyclistes_finis.length; i++) {
        var cycliste = this.cyclistes_finis[i];
        //console.log("Cycliste fini : " + cycliste);

        const cyclisteACheck = this.joueur.getCyclisteTest(choixCycliste);
        if (!this.cyclistes_finis.includes(cyclisteACheck)) {
          this.cyclistes_finis.push(cyclisteACheck);
         // console.log("Ajout cycliste : " + cyclisteACheck);
        }
      }
    }

    return messageReturn;
  }


  /**
   * Retourne le cycliste qui devra jouer au prochain tour
   * 
   * @param {string} nom du joueur
   * @returns  {number} cycliste qui doit jouer
   */
  cycliste_qui_doit_jouer(nom) {
    var numeroCyclisteAJouer;
    
    // Check le nom du joeuur
    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
        //console.log("Joueur non trouvé.");
        break;
    }

    // Check si premier tour fini
    if (this.premierTour > 11) {
      // Si le tableau d'historique des positions de cyclistes est vide, on récupère les positions de tous les cyclistes du joueur
      if (this.historiquePositionCycliste.length === 0) {
        var positions = this.joueur.get_positions_cyclistes();
        for (var i = 0; i < positions.length; i++) {
          this.historiquePositionCycliste.push(positions[i]);
        }
      }

      var lowestPositionIndex = 0;

      // Chercher le Cycliste avec la position la plus basse du tableau (à savoir la nbligne plus petite)
      for (var i = 0; i < this.historiquePositionCycliste.length; i++) {
        if (this.historiquePositionCycliste[i].ligne < this.historiquePositionCycliste[lowestPositionIndex].ligne) {
          lowestPositionIndex = i;
          numeroCyclisteAJouer = this.historiquePositionCycliste[i].numero;
        }
      }

      return numeroCyclisteAJouer;
    }
    else {
      return this.currentCyclisteIndex;
    }

  }

  /**
   * DYNAMIQUE : Permet de faire dépalcer un cycliste.
   * 
   * @param {string} nom du joueur
   * @param {number} choixCarte numéro du cycliste
   * @returns {string} Une chaine de character contenant les informations sur le déplacement du cycliste.
   */
  deplacer_dynamique(nom, choixCarte, choixColonne) {
    var messageReturn;
    var lowestPositionIndex = 0;
    var cyclisteJouer;
    var elemDelete;
    var elemCyclisteDelete;
    var numeroCyclisteAJouer;


    // Check le nom du joeuur
    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
        //console.log("Joueur non trouvé.");
        break;
    }


    // Récupère les positions de tout les cyclistes de chaque joueur
    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();

    // Check si premier tour fini
    if (this.premierTour > 11) {

      // Si le tableau d'historique des positions de cyclistes est vide, on récupère les positions de tous les cyclistes du joueur
      if (this.historiquePositionCycliste.length === 0) {
        var positions = this.joueur.get_positions_cyclistes();
        for (var i = 0; i < positions.length; i++) {
          this.historiquePositionCycliste.push(positions[i]);
        }
      }


      // Chercher le Cycliste avec la position la plus basse du tableau (à savoir la nbligne plus petite)
      for (var i = 0; i < this.historiquePositionCycliste.length; i++) {
        if (this.historiquePositionCycliste[i].ligne < this.historiquePositionCycliste[lowestPositionIndex].ligne) {
          lowestPositionIndex = i;
          numeroCyclisteAJouer = this.historiquePositionCycliste[i].numero;
        }
      }

      // Supprimer cycliste jouer du tableau
      elemDelete = this.historiquePositionCycliste.splice(lowestPositionIndex, 1);
      //console.log("Elem supprimer !", elemDelete);


      // Quand dernier elem supprimer du tableau this.historiquePositionCycliste, on récupère la valeur supprimer afin de la traité (merci javascript)
      if (numeroCyclisteAJouer === undefined) {
        numeroCyclisteAJouer = elemDelete[0].numero;
      }

      //Récupère l'objet cycliste.
      cyclisteJouer = this.joueur.getNumCycliste(numeroCyclisteAJouer);

      // Check si cycliste a chuté 
      var test = this.joueur.getCyclistes2();
      for (var i = 0; i < test.length; i++) {
        for (var j = 0; j < this.cycliste_chute.length; j++) {
          if (test[i].nom === this.cycliste_chute[j].nom) {
            if (test[i] === this.joueur.getCyclisteTest(cyclisteJouer)) {

              elemCyclisteDelete = this.cycliste_chute.splice(j, 1);
              //console.log("Cycliste  supprimer du tableau cycliste_chute !", elemCyclisteDelete);

              //console.log("Le cycliste a chuté et ne peut pas jouer !");
              return "Le cycliste a chuté et ne peut pas jouer !";
            }
          }
        }
      }

      // Appel la méthode deplacer_cycliste();
      if (!this.cycliste_fin_course(this.joueur, cyclisteJouer)) {
        messageReturn = this.joueur.deplacer_cycliste(cyclisteJouer, choixCarte, choixColonne, this.plateau, this.cycliste_chute, this.cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
        this.jouer_carte_jeu(this.joueur, choixCarte);
        this.joueur.secondes_acc(cyclisteJouer, 10);
      }
      else {
        messageReturn = "Le cycliste a déjà atteint la ligne d'arrivé";
        //console.log(messageReturn);
        if (this.cyclistes_finis.length === 0) {
          this.cyclistes_finis.push(this.joueur.getCyclisteTest(cyclisteJouer));
        }
        for (var i = 0; i < this.cyclistes_finis.length; i++) {
          var cycliste = this.cyclistes_finis[i];
          //console.log("Cycliste fini : " + cycliste);

          const cyclisteACheck = this.joueur.getCyclisteTest(cyclisteJouer);
          if (!this.cyclistes_finis.includes(cyclisteACheck)) {
            this.cyclistes_finis.push(cyclisteACheck);
           // console.log("Ajout cycliste : " + cyclisteACheck);
          }
        }
      }

    }

    //Premier tour pour chaque joueur, il joue leur cycliste 1 à 3 dans l'ordre.
    else {
      messageReturn = this.joueur.deplacer_cycliste(this.currentCyclisteIndex, choixCarte, choixColonne, this.plateau, this.cycliste_chute, this.cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      this.jouer_carte_jeu(this.joueur, choixCarte);
    }

    //Incrémente this.currentCyclisteIndex tant que inférieur à 3, sinon le init à 1.
    if (this.currentCyclisteIndex < 3) {
      this.currentCyclisteIndex++;
    }
    else {
      this.currentCyclisteIndex = 1;
    }

    this.premierTour++;

    return messageReturn;
  }


  /**
   * Vérifie si un cycliste a terminé la course.
   * 
   * @param {string} nom du joueur
   * @param {number} cyclisteJouer numéro du cycliste
   * @returns {boolean} Un booléen indiquant si le cycliste a terminé la course ou non.
   */
  cycliste_fin_course(nom, cyclisteJouer) {
    const cyclisteObject = nom.cyclistes.find(cycliste => cycliste.numero === cyclisteJouer);
    if (cyclisteObject.getFinCircuit()) {
      return true;
    }
    else {
      return false;
    }
  }



  /*
  afficher_position_cycliste() {
    console.log("Positions de tous les cyclistes :");
    this.belgique.afficher_positions_cyclistes();
    this.italie.afficher_positions_cyclistes();
    this.hollande.afficher_positions_cyclistes();
    this.allemagne.afficher_positions_cyclistes();
  }*/


  /**
   * Récupère la position d'un cycliste.
   * 
   * @param {string} nom du joueur
   * @param {number} cycliste  numéro du cycliste
   * @returns {string} Chaîne de caractères contenant la position du cycliste
   */
  get_position_cycliste(nom, cycliste) {
    let position = null;
    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
        //console.log("Joueur non trouvé.");
        break;
    }

    position = this.joueur.get_position_cycliste(cycliste);
    return position;

  }



  /******************************
  *                             *
  *            Cartes           *
  *                             *
  *******************************/

  /**
   * Créer les cartes avec des valeurs de 1 à 12
   */
  init_cartes() {
    for (let i = 1; i <= 12; i++) {
      for (let j = 0; j < 8; j++) {
        this.cartes.push(new Carte(i));
      }
    }
  }

  /**
   * Mélange les cartes du paquet en utilisant l'algorithme de Fisher-Yates.
   */
  melanger_cartes(paquet) {
    for (let i = paquet.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [paquet[i], paquet[j]] = [paquet[j], paquet[i]];
    }
  }

  /**
   * Distribue 5 cartes à chaque joueur au début du jeu.
   * Les cartes sont distribuées de manière aléatoire depuis le paquet de cartes.
   */
  distribuer_cartes_debut_jeu() {
    const joueurs = [this.italie, this.hollande, this.belgique, this.allemagne];
    const playerCards = [];
    for (const joueur of joueurs) {
      //console.log(`Cartes distribuées à ${joueur.nom}:`);
      for (let i = 0; i < 5; i++) {
        const carte = this.cartes.pop();
        joueur.recevoir_cartes([carte]);
        playerCards.push(carte.valeur);
        //console.log(`Carte ${i + 1}: ${carte.valeur}`);
      }

      // Envoyer les cartes du joueur via WebSocket
      //inputUser.sendPlayerCards(playerCards, joueur.nom);
    }
  }

  /**
   * Affiche les cartes restantes du paquet.
   */
  afficher_nombre_cartes_restantes() {
    //console.log(`Il reste ${this.cartes.length} cartes dans le paquet.`);
    for (var i = 0; i < this.cartes.length; i++) {
      //console.log(this.cartes[i].valeur);
    }
  }

  /**
   * Joue une carte du joueur ou pioche de nouvelles cartes s'il n'en reste plus.
   * Met les objets des cartes jouées dans une liste.
   *
   * @param {string} nom du joueur
   * @param {number} choixCarte  carte que le joueur doit jouer.
   * @returns la méthode jouer_carte() ou piocher_cartes()
   */
  jouer_carte_jeu(nom, choixCarte) {
    if (nom.cartes.length > 1) {
      const carteJouee = nom.jouer_carte(choixCarte);
      this.cartesDepot.push(carteJouee);
      for (var i = 0; i < this.cartesDepot.length; i++) {
       // console.log("Cartes dépot " + this.cartesDepot[i].valeur);
      }
      return carteJouee;
    }
    else {
      // Appel piocher_cartes(), sa dernière carte sera jouer là-bas
      return this.piocher_cartes(choixCarte);
    }
  }

  /**
   * Mélange les cartes de this.cartesDepot, redistribue les cartes dans this.cartes et vide this.cartesDepot.
   */
  carte_depot() {
    this.melanger_cartes(this.cartesDepot)
    this.cartes = this.cartes.concat(this.cartesDepot);
    this.cartesDepot = [];
  }

  /**
   * Pioche des cartes pour un joueur donné et lui donne la possibilité de jouer l'une de ses cartes.
   * 
   * @param {number} choixCarte carte que le joueur doit encorer jouer.
   */
  piocher_cartes(choixCarte) {

    // Vérifier qu'il y a suffisamment de cartes dans le paquet
    if (this.cartes.length < 5) {
      console.log(`Il n'a plus de carte dans le paquet.`);
      this.carte_depot();
    }

    // Joue sa dernière carte
    this.joueur.jouer_carte(choixCarte);

    // Donner des cartes au joueur
    for (let i = 0; i < 5; i++) {
      const carte = this.cartes.pop();
      this.joueur.recevoir_cartes([carte]);
    }

    // Affiche les cartes restantes du paquet
    this.afficher_nombre_cartes_restantes();

  }

  /**
   * Récupère les cartes d'un joueur.
   * 
   * @param {string} nom le nom du joueur dont on veut récupérer les cartes.
   * @returns  un tableau contenant les cartes du joueur.
   */
  getCartes_du_joueur(nom) {
    switch (nom) {
      case "Belgique":
        this.joueur = this.belgique;
        break;
      case "Italie":
        this.joueur = this.italie;
        break;
      case "Hollande":
        this.joueur = this.hollande;
        break;
      case "Allemagne":
        this.joueur = this.allemagne;
        break;
      default:
        //console.log("Joueur non trouvé.");
        break;
    }
    //console.log(this.joueur.getCarte());
    return this.joueur.getCarte();
  }

  /******************************
  *                             *
  *          Fin du jeu         *
  *                             *
  *******************************/

  /**
   * Vérifie si tout les cyclistes_finis ont finis la course.
   * 
   * @returns {bollean} Un booléen indiquant si le jeu est terminé la course ou non.
   */
  check_fin_jeu() {
    if (this.cyclistes_finis.length === 12) {
      return true;
    }
    return false;
  }


  /**
   * Affiche la fin du jeu et calcule les points de chaque joueur.
   * Trie ensuite les joueurs par ordre croissant de score et affiche le classement final.
   * 
   * @returns {string} Chaîne de caractères contenant le classement final avec le numéro de position, le nom du joueur et son score.
   */
  fin_jeu() {
    console.log("Fin du jeu");

    var messageReturn = "";

    // Calcul des points de chaque joueur
    this.belgique.calcul_points();
    this.italie.calcul_points();
    this.hollande.calcul_points();
    this.allemagne.calcul_points();

    const scoreBelgique = this.belgique.getPoints();
    const scoreItalie = this.italie.getPoints();
    const scoreHollande = this.hollande.getPoints();
    const scoreAllemagne = this.allemagne.getPoints();

    const scores = [
      { nom: "Belgique", score: scoreBelgique },
      { nom: "Italie", score: scoreItalie },
      { nom: "Hollande", score: scoreHollande },
      { nom: "Allemagne", score: scoreAllemagne },
    ];

    // Trier le tableau par ordre croissant de score
    scores.sort((a, b) => a.score - b.score);

    console.log("Belgique ", this.belgique.getPoints());
    console.log("Italie ", this.italie.getPoints());
    console.log("Hollande ", this.hollande.getPoints());
    console.log("Allemagne ", this.allemagne.getPoints());


    // Affiche le classement final
    console.log("Classement final :");
    for (let i = 0; i < scores.length; i++) {
      console.log(`${i + 1}. ${scores[i].nom} - ${scores[i].score} points`);
      messageReturn = messageReturn + ` ${i + 1}. ${scores[i].nom} - ${scores[i].score} points <br>`;
    }

    return messageReturn;
  }


}

export default Jeu; // Export de la classe Game
