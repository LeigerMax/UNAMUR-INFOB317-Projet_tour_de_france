import Position from './Position';

class Cycliste {
    constructor(numero) {
      this.numero = numero;
      this.position = new Position(0, 0);
      this.fin_circuit = false;
    }
    
    getNumero() { return this.numero; }

    getPosition() { return this.position; }

    getPosition2() { return { numero: this.numero, ligne: this.position.getLigne(), colonne: this.position.getColonne() }; }

    getPosition3() { return  `${this.position.getLigne()},  ${this.position.getColonne()} `; }



    afficher_position() {
      console.log(`Cycliste ${this.numero} : [${this.position.getLigne()},${this.position.getColonne()}]`);
    }


    // déplacer ok
    deplacement(choixCarte,plateau,belgique_positions,italie_positions,hollande_positions,allemagne_positions) {
      const nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
      var nouvelle_colonne = 1;

      // Vérifier si un cycliste est déjà présent dans la position
      while (
        belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
        italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
        hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
        allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
      ) {
        console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
        nouvelle_colonne++;
      }


      //Check si case valide
      if (plateau.check_position_plateau(nouvelle_ligne,nouvelle_colonne)) {
        console.log(`La position ${nouvelle_ligne,nouvelle_colonne} est valide.`);
      } 
      else {
        console.log(`La position ${nouvelle_ligne,nouvelle_colonne} est invalide.`);
        this.chute(nouvelle_ligne,this.numero,belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      }

      //Set values
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);

      console.log(`Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);

    }

    chute(nouvelle_ligne,numero,belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
      const ligne_chute = nouvelle_ligne;
      const nums_chutes = [numero];
    
      console.log(`Chute de tous les cyclistes de la ligne ${ligne_chute} !`);
      belgique_positions.forEach(pos => {if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero)});
      italie_positions.forEach(pos => {if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero)});
      hollande_positions.forEach(pos => {if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero)});
      allemagne_positions.forEach(pos => {if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero)});

      console.log(`Les cyclistes suivants sont tombés: ${nums_chutes.join(', ')}`);
      
    }
    


    toString(){
      return "Nom : "+this.nom+ " | Posiiton : "+this.pos
    }
  

  }
  
export default Cycliste;