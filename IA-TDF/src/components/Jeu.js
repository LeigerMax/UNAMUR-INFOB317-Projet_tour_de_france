import Joueur from './Joueur';
import Cycliste from './Cycliste';
import Carte from './Carte';
import Plateau from './Plateau';

class Jeu {
  constructor() {
    this.cartes = [];
    this.plateau = new Plateau();
    this.joueursList = [];
    this.currentCyclisteIndex = 1; // initialisé à 1 pour le premier cycliste
    this.historiquePositionCycliste = [];
    this.tour = 0;
  }


  // Méthodes pour la logique du jeu
  debut_jeu(dev) {
    console.log("Lancement");
    this.init_joueurs();
    this.init_cartes();
    this.melanger_cartes();
    this.distribuer_cartes_debut_jeu();
    this.afficher_nombre_cartes_restantes();

  }

  /******************************
  *                             *
  *            Joueur           *
  *                             *
  *******************************/


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

    console.log("LIST : ", this.joueursList);

    // Création des cyclistes pour chaque joueur
    for (let i = 1; i <= 3; i++) {
      this.belgique.ajouter_cycliste(new Cycliste(i));
      this.italie.ajouter_cycliste(new Cycliste(i));
      this.hollande.ajouter_cycliste(new Cycliste(i));
      this.allemagne.ajouter_cycliste(new Cycliste(i));
    }

    // Affichage des joueurs avec leurs cyclistes
    console.log("Belgique : ", this.belgique);
    console.log("Italie : ", this.italie);
    console.log("Hollande : ", this.hollande);
    console.log("Allemagne : ", this.allemagne);
  }

  


  /******************************
  *                             *
  *            Cycliste         *
  *                             *
  *******************************/

  // déplacemeent d'un cycliste (dev)
  deplacer_dev(nom, choixCycliste, choixCarte) {
    console.log("DEV : Dépalacer");
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


    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();

    const messageReturn = this.joueur.deplacer_cycliste(choixCycliste, choixCarte, this.plateau, belgique_positions, italie_positions, hollande_positions, allemagne_positions);

    return messageReturn;
  }

  // déplacemeent d'un cycliste (dynamique)
  deplacer_dynamique(nom, choixCarte) {
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

    

    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();

    var messageReturn;
    

    // Premier tour pour chaque joueur, il joue leur cycliste 1 à 3 dans l'ordre.
    if(this.tour > 11) {

      // Si le tableau d'historique des positions de cyclistes est vide, 
      // on récupère les positions de tous les cyclistes du joueur
      if (this.historiquePositionCycliste.length === 0) {
        var positions = this.joueur.get_positions_cyclistes();
        for (var i = 0; i < positions.length; i++) {
          this.historiquePositionCycliste.push(positions[i]);
        }
      }


      console.log("TABLEAU : ", this.historiquePositionCycliste);

      // Chercher le Cycliste avec la position la plus basse du tableau (à savoir la nbligne plus petite)
      var lowestPositionIndex = 0;
      var numeroPosition;
      var cycliste_jouer;

      for (var i = 0; i < this.historiquePositionCycliste.length; i++) {
        if (this.historiquePositionCycliste[i].ligne < this.historiquePositionCycliste[lowestPositionIndex].ligne) {
          lowestPositionIndex = i;
          numeroPosition = this.historiquePositionCycliste[i].numero;
        }
      }

      
      // Supprimer cycliste jouer du tableau
      var elemDelete;
      elemDelete = this.historiquePositionCycliste.splice(lowestPositionIndex, 1);
      console.log("Elem supprimer !",elemDelete);

      if(numeroPosition !== undefined) {
        console.log("Cycliste plus petite position : ", numeroPosition);
      }
      else{
        numeroPosition = elemDelete[0].numero;
      }

      cycliste_jouer = this.joueur.getNumCycliste(numeroPosition);

    
      messageReturn = this.joueur.deplacer_cycliste(cycliste_jouer, choixCarte, this.plateau, belgique_positions, italie_positions, hollande_positions, allemagne_positions);


    }
    else {
       messageReturn = this.joueur.deplacer_cycliste(this.currentCyclisteIndex, choixCarte, this.plateau, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
    }

    if (this.currentCyclisteIndex < 3) {
      this.currentCyclisteIndex++;
    }
    else {
      this.currentCyclisteIndex = 1;
    }

    this.tour++;

    return messageReturn;
  }


  afficher_position_cycliste() {
    console.log("Positions de tous les cyclistes :");
    this.belgique.afficher_positions_cyclistes();
    this.italie.afficher_positions_cyclistes();
    this.hollande.afficher_positions_cyclistes();
    this.allemagne.afficher_positions_cyclistes();
  }



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
        console.log("Joueur non trouvé.");
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

  init_cartes() {
    // Créer les cartes avec des valeurs de 1 à 12
    for (let i = 1; i <= 12; i++) {
      for (let j = 0; j < 8; j++) {
        this.cartes.push(new Carte(i));
      }
    }
  }

  melanger_cartes() {
    // Mélanger les cartes en utilisant l'algorithme de Fisher-Yates
    for (let i = this.cartes.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.cartes[i], this.cartes[j]] = [this.cartes[j], this.cartes[i]];
    }
  }

  distribuer_cartes_debut_jeu() {
    const joueurs = [this.italie, this.hollande, this.belgique, this.allemagne];
    for (const joueur of joueurs) {
      console.log(`Cartes distribuées à ${joueur.nom}:`);
      for (let i = 0; i < 5; i++) {
        const carte = this.cartes.pop();
        joueur.recevoir_cartes([carte]);
        console.log(`Carte ${i + 1}: ${carte.valeur}`);
      }
    }
  }

  afficher_nombre_cartes_restantes() {
    console.log(`Il reste ${this.cartes.length} cartes dans le paquet.`);
  }

  jouer_carte_jeu(nom, choixCarte) {
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
    if (this.joueur.cartes.length > 1) {
      return this.joueur.jouer_carte(choixCarte);
    }
    else {
      // Appel piocher_cartes(), sa dernière carte sera jouer là-bas
      return this.piocher_cartes(choixCarte);
    }

  }

  piocher_cartes(choixCarte) {
    // Vérifier qu'il y a suffisamment de cartes dans le paquet
    if (this.cartes.length < 5) {
      throw new Error('Pas assez de cartes dans le paquet.');
    }

    // Joue sa dernière carte
    this.joueur.jouer_carte(choixCarte);

    // Donner des cartes au joueur
    for (let i = 0; i < 5; i++) {
      const carte = this.cartes.pop();
      this.joueur.recevoir_cartes([carte]);
    }

    this.afficher_nombre_cartes_restantes();

  }

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
        console.log("Joueur non trouvé.");
        break;
    }
    console.log(this.joueur.getCarte());
    return this.joueur.getCarte();
  }




  fin_jeu() {
    console.log("Fin du jeu");
  }



}

export default Jeu; // Export de la classe Game
