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

    getCyclistes2() {
      return this.cyclistes;
    }

    ajouter_cycliste(cycliste) {
      // Vérifier si le joueur a déjà le maximum de cyclistes
      if (this.cyclistes.length >= 3) {
        console.log("Le joueur " + this.nom + " a déjà le maximum de cyclistes.");
        return;
      }
  
      // Ajouter le cycliste à la liste des cyclistes du joueur
      this.cyclistes.push(cycliste);
  
      console.log("Le cycliste " + cycliste.numero + " a été ajouté à la liste des cyclistes du joueur " + this.nom + ".");
    }



    // déplacer ok
    deplacer_cycliste(choixCycliste,choixCarte,plateau,belgique_positions,italie_positions,hollande_positions,allemagne_positions) {
      // Trouver le cycliste dans la liste des cyclistes du joueur
      const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);
 
      if (!cycliste) {
        console.log("Le cycliste " + choixCycliste + " n'appartient pas à la liste des cyclistes du joueur " + this.nom + ".");
        return;
      }

  
      // Déplacer le cycliste en fonction de la distance obtenue
      cycliste.deplacement(choixCarte, plateau,belgique_positions,italie_positions,hollande_positions,allemagne_positions);
  
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

    get_positions_cyclistes() {
      this.position_all_cycliste = [];
      this.cyclistes.forEach(cycliste => {
        this.position_all_cycliste.push(cycliste.getPosition2());
      });
      return this.position_all_cycliste;
    }

    get_position_cycliste(cyclisteNombre) {
      this.positionDuCycliste = null;
      this.cyclistes.forEach(cycliste => {
        if(cycliste.numero === cyclisteNombre) {
          this.positionDuCycliste = cycliste.getPosition3();
        }
      });
      return this.positionDuCycliste;
    }
  
  }
  
  export default Joueur;