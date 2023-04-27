import Position from './Position';

class Cycliste {
    constructor(numero) {
      this.numero = numero;
      this.position = new Position(0, 0);
      this.fin_circuit = false;
    }
    
    getNumero() { return this.numero; }


    // Surchage déplacer pour dev
    deplacement_dev(distance_ligne,distance_colonne) {
      const nouvelle_ligne = this.position.getLigne() + distance_ligne;
      const nouvelle_colonne = distance_colonne;
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);
      console.log(`Le cycliste ${this.numero} se déplace de ${distance_ligne} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);
    }

    // déplacer ok
    deplacement(choixCarte) {
      const nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
      //TODO: Si un joueur est déjà présent dans la position
      const nouvelle_colonne = 1;
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);
      console.log(`Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);
    }


    toString(){
      return "Nom : "+this.nom+ " | Posiiton : "+this.pos
    }
  

  }
  
export default Cycliste;