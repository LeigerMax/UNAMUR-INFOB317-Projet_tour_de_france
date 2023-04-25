import Position from './Position';

class Cycliste {
    constructor(numero) {
      this.numero = numero;
      this.position = new Position(0, 0);
      this.fin_circuit = false;
    }
    
    getNumero() { return this.numero; }


    deplacement(distance_ligne,distance_colonne) {
      const nouvelle_ligne = this.position.getLigne() + distance_ligne
      const nouvelle_colonne = distance_colonne
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);
      console.log(`Le cycliste ${this.numero} se déplace de ${distance_ligne} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);
    }

    toString(){
      return "Nom : "+this.nom+ " | Posiiton : "+this.pos
    }
  

  }
  
export default Cycliste;