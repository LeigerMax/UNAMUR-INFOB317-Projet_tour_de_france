import Cycliste from "./Cycliste";
import Jeu from "./Jeu";

class Joueur {
    constructor(nom) {
      this.nom = nom;
      this.cartes = [];
      this.cyclistes = [];
    }

    getNom() { return this.nom; }
    
    /******************************
     *                            *
     *        Cyclistes           *
     *                            *
     ******************************/

    getCyclistes() { 
      const numeros = [];

      for (const cycliste of this.cyclistes) {
        numeros.push(cycliste);
      }
    
      // Retourner le tableau des numéros des cyclistes
      return numeros;
    }

    ajouterCycliste(cycliste) {
      // Vérifier si le joueur a déjà le maximum de cyclistes
      if (this.cyclistes.length >= 3) {
        console.log("Le joueur " + this.nom + " a déjà le maximum de cyclistes.");
        return;
      }
  
      // Ajouter le cycliste à la liste des cyclistes du joueur
      this.cyclistes.push(cycliste);
  
      console.log("Le cycliste " + cycliste.numero + " a été ajouté à la liste des cyclistes du joueur " + this.nom + ".");
    }


    // Surchage déplacer pour dev
    deplacerCycliste_dev(choixCycliste,choixCarte, lignePosition, colonnePosition) {
     // Trouver le cycliste dans la liste des cyclistes du joueur
     const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);
     console.log("Surchage");

     if (!cycliste) {
       console.log("Le cycliste " + choixCycliste + " n'appartient pas à la liste des cyclistes du joueur " + this.nom + ".");
       return;
     }
 
     // Déplacer le cycliste en fonction de la distance obtenue
     cycliste.deplacement_dev(lignePosition, colonnePosition);

 
     console.log(`Le joueur ${this.nom} a déplacé le cycliste ${choixCycliste} avec la carte ${choixCarte} de ${lignePosition} lignes devant et à la colonne ${colonnePosition}.`);
    }

    // déplacer ok
    deplacerCycliste(choixCycliste,choixCarte) {
      // Trouver le cycliste dans la liste des cyclistes du joueur
      const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);
 
      if (!cycliste) {
        console.log("Le cycliste " + choixCycliste + " n'appartient pas à la liste des cyclistes du joueur " + this.nom + ".");
        return;
      }
  
      // Déplacer le cycliste en fonction de la distance obtenue
      cycliste.deplacement(choixCarte);
 
  
      console.log(`Le joueur ${this.nom} a déplacé le cycliste ${choixCycliste} avec la carte ${choixCarte}.`);
     }


    /******************************
     *                            *
     *         Cartes             *
     *                            *
     ******************************/


    recevoir_cartes(cartes) {
      this.cartes = this.cartes.concat(cartes);
    }

    jouer_carte(choixCarte) {
      // Trouver l'index de la carte dans le tableau de cartes du joueur
      const index = this.cartes.findIndex(carte => carte.valeur === parseInt(choixCarte));
      if (index !== -1) {
        // Supprimer la carte du tableau de cartes du joueur
        this.cartes.splice(index, 1);
      }

    }


    getCarte() { 
      const numeros = [];

      for (const carte of this.cartes) {
        numeros.push(carte);
      }
    
      // Retourner le tableau des numéros des cyclistes
      return numeros;
    }

    
  
  }
  
  export default Joueur;