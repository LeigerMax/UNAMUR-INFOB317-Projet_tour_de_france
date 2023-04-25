import Joueur from './Joueur';
import Cycliste from './Cycliste';

class Jeu {
    constructor() {
      // Initialisation du jeu
    }
  
    // Méthodes pour la logique du jeu
    debut_jeu() {
      console.log("Lancement");
      this.init_player();
    }

  

    init_player() {
      // Création des joueurs
       this.belgique = new Joueur("Belgique");
       this.italie = new Joueur("Italie");
       this.hollande = new Joueur("Hollande");
       this.allemagne = new Joueur("Allemagne");

      // Création des cyclistes pour chaque joueur
      for (let i = 1; i <= 3; i++) {
        this.belgique.ajouterCycliste(new Cycliste(i));
        this.italie.ajouterCycliste(new Cycliste(i));
        this.hollande.ajouterCycliste(new Cycliste(i));
        this.allemagne.ajouterCycliste(new Cycliste(i));
      }

      // Affichage des joueurs avec leurs cyclistes
      console.log("Belgique : ", this.belgique);
      console.log("Italie : ", this.italie);
      console.log("Hollande : ", this.hollande);
      console.log("Allemagne : ", this.allemagne);
    }

    deplacer(nom, choixCycliste,choixCarte, lignePosition, colonnePosition) {
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
        case "Italie":
          this.Allemagne = this.allemagne;  
          break;
        default:
          console.log("Joueur non trouvé.");
          break;
        }

        this.joueur.deplacerCycliste(nom, choixCycliste,choixCarte, lignePosition, colonnePosition);
    }

  
    fin_jeu() {
      console.log("Fin du jeu");
    }
  
    // Autres méthodes pour la logique du jeu
  }
  
  export default Jeu; // Export de la classe Game
  