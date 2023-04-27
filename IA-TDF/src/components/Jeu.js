import Joueur from './Joueur';
import Cycliste from './Cycliste';
import Carte from './Carte';
import Plateau from './Plateau';

class Jeu {
    constructor() {
      this.cartes = [];
      this.plateau = new Plateau();
    }
    
  
    // Méthodes pour la logique du jeu
    debut_jeu() {
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

      // déplacer jeu
      deplacer(nom, choixCycliste,choixCarte) {
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


          let positionsCyclistes = [];
          console.log("Position test");
          var belgique_positions = this.belgique.get_positions_cyclistes();
          var italie_positions = this.italie.get_positions_cyclistes();
          var hollande_positions = this.hollande.get_positions_cyclistes();
          var allemagne_positions = this.allemagne.get_positions_cyclistes();
  
          this.joueur.deplacer_cycliste(choixCycliste,choixCarte,this.plateau,belgique_positions,italie_positions,hollande_positions,allemagne_positions);
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

    jouer_carte_jeu(nom,choixCarte) {
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


    afficher_position_cycliste() {
      console.log("Positions de tous les cyclistes :");
      this.belgique.afficher_positions_cyclistes();
      this.italie.afficher_positions_cyclistes();
      this.hollande.afficher_positions_cyclistes();
      this.allemagne.afficher_positions_cyclistes();
    }


    fin_jeu() {
      console.log("Fin du jeu");
    }


    get_position_cycliste(nom,cycliste) {
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

    


  }
  
  export default Jeu; // Export de la classe Game
  