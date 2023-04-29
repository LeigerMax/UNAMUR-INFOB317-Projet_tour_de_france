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
    this.cycliste_chute = [];
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
      this.belgique.ajouter_cycliste(new Cycliste(i,"be"+i));
      this.italie.ajouter_cycliste(new Cycliste(i,"it"+i));
      this.hollande.ajouter_cycliste(new Cycliste(i,"ho"+i));
      this.allemagne.ajouter_cycliste(new Cycliste(i,"al"+i));
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
        console.log("Joueur non trouvé.");
        break;
    }

    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();

    // Appel la méthode deplacer_cycliste();
    if(!this.cycliste_fin_course(this.joueur,choixCycliste)) {
      messageReturn = this.joueur.deplacer_cycliste(choixCycliste, choixCarte, this.plateau,this.cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      this.jouer_carte_jeu(this.joueur,choixCarte);
    }
    else {
      messageReturn = "Le cycliste a déjà atteint la ligne d'arrivé";
      console.log(messageReturn);
    }
      


    return messageReturn;
  }

  // déplacemeent d'un cycliste (dynamique)
  deplacer_dynamique(nom, choixCarte) {
    var messageReturn;
    var lowestPositionIndex = 0;
    var numeroCyclisteAJouer;
    var cyclisteJouer;
    var elemDelete;
    var elemCyclisteDelete;


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
        console.log("Joueur non trouvé.");
        break;
    }


    // Importe les positions des cyclistes de chaque joueurs
    var belgique_positions = this.belgique.get_positions_cyclistes();
    var italie_positions = this.italie.get_positions_cyclistes();
    var hollande_positions = this.hollande.get_positions_cyclistes();
    var allemagne_positions = this.allemagne.get_positions_cyclistes();

    

    // Check si premier tour fini
    if(this.tour > 11) {

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
      console.log("Elem supprimer !",elemDelete);


      // Quand dernier elem supprimer du tableau this.historiquePositionCycliste
      if(numeroCyclisteAJouer === undefined) {
        numeroCyclisteAJouer = elemDelete[0].numero;
      }

      //Récupère l'objet cycliste.
      cyclisteJouer = this.joueur.getNumCycliste(numeroCyclisteAJouer);

      // Check si cycliste a chuté 
      var test =this.joueur.getCyclistes2();
      for (var i = 0; i < test.length; i++) {
        for (var j = 0; j < this.cycliste_chute.length; j++) {
          if(test[i].nom === this.cycliste_chute[j].nom) {
            if(test[i] === this.joueur.getCyclisteTest(cyclisteJouer)) {

              elemCyclisteDelete = this.cycliste_chute.splice(j, 1);
              console.log("Cycliste  supprimer du tableau cycliste_chute !",elemCyclisteDelete);

              console.log("Le cycliste a chuté et ne peut pas jouer !");
              return "Le cycliste a chuté et ne peut pas jouer !";
            }
          }
        }
      }
  
      // Appel la méthode deplacer_cycliste();
      if(!this.cycliste_fin_course(this.joueur,cyclisteJouer)) {
        messageReturn = this.joueur.deplacer_cycliste(cyclisteJouer, choixCarte, this.plateau,this.cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
        this.jouer_carte_jeu(this.joueur,choixCarte);
      }
      else {
        messageReturn = "Le cycliste a déjà atteint la ligne d'arrivé";
        console.log(messageReturn);
      }
     

    }

    //Premier tour pour chaque joueur, il joue leur cycliste 1 à 3 dans l'ordre.
    else {
       messageReturn = this.joueur.deplacer_cycliste(this.currentCyclisteIndex, choixCarte, this.plateau,this.cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
    }

    //Incrémente this.currentCyclisteIndex tant que inférieur à 3, sinon le init à 1.
    if (this.currentCyclisteIndex < 3) {
      this.currentCyclisteIndex++;
    }
    else {
      this.currentCyclisteIndex = 1;
    }

    this.tour++;

    return messageReturn;
  }


  cycliste_fin_course(nom,cyclisteJouer){
    const cycliste2 = nom.cyclistes.find(cycliste => cycliste.numero === cyclisteJouer);
    if(cycliste2.getFinCircuit()) {
      return true;
    }
    else {
      return false;
    }
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
    if (nom.cartes.length > 1) {
      return nom.jouer_carte(choixCarte);
    }
    else {
      // Appel piocher_cartes(), sa dernière carte sera jouer là-bas
      return this.piocher_cartes(choixCarte);
    }

  }

  piocher_cartes(choixCarte) {
    // Vérifier qu'il y a suffisamment de cartes dans le paquet
    if (this.cartes.length < 5) {
      console.log(`Il n'a plus de carte dans le paquet.`);
      this.init_cartes();
      this.melanger_cartes();
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
