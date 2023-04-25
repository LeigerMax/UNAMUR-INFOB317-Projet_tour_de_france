import Cycliste from "./Cycliste";

class Joueur {
    constructor(nom) {
      this.nom = nom;
      this.cartes = [];
      this.cyclistes = [];
    }

    getNom() { return this.nom; }

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


    deplacerCycliste(nom, choixCycliste,choixCarte, lignePosition, colonnePosition) {
     // Trouver le cycliste dans la liste des cyclistes du joueur
     const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);

     if (!cycliste) {
       console.log("Le cycliste " + choixCycliste + " n'appartient pas à la liste des cyclistes du joueur " + this.nom + ".");
       return;
     }
 
     // Déplacer le cycliste en fonction de la distance obtenue
     cycliste.deplacement(lignePosition, colonnePosition);

 
     console.log(`Le joueur ${this.nom} a déplacé le cycliste ${choixCycliste} avec la carte ${choixCarte} de ${lignePosition} lignes devant et à la colonne ${colonnePosition}.`);
    }
    
  
  }
  
  export default Joueur;