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

  getPosition3() { return `${this.position.getLigne()},  ${this.position.getColonne()}`; }



  afficher_position() {
    console.log(`Cycliste ${this.numero} : [${this.position.getLigne()},${this.position.getColonne()}]`);
  }


  // déplacer ok
  deplacement(choixCarte, plateau, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    var nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
    var nouvelle_colonne = 1;
    var messageReturn = "";

    
    while (
      belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
    ) {
      nouvelle_colonne++;
      messageReturn = console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
    }


    //Check si case valide
    if (plateau.check_position_plateau(nouvelle_ligne, nouvelle_colonne)) {
      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est valide.`);
      messageReturn = "Place libre";
      const case_chance = plateau.check_case_chance_plateau(nouvelle_ligne, nouvelle_colonne);
      // si cycliste est sur une case chance 
      if (case_chance) {
        messageReturn = messageReturn + " <br> Le cycliste est tombé sur une case chance";
        console.log("case chance");
        const random_chance = Math.floor(Math.random() * 7) - 3;
        if (random_chance < 0) {
          console.log(`Le cycliste recule de ${Math.abs(random_chance)} cases.`);
          messageReturn = messageReturn + " <br> Le cycliste recule de " + Math.abs(random_chance) + " case(s).";
          nouvelle_ligne = nouvelle_ligne - Math.abs(random_chance);

          while (
            belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
          ) {
            nouvelle_colonne++;
            messageReturn = console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
          }
      
        }
        else if (random_chance > 0) {
          console.log(`Le cycliste avance de ${random_chance} cases.`);
          messageReturn = messageReturn + " <br> Le cycliste avance de " + random_chance + " case(s).";
          nouvelle_ligne = nouvelle_ligne + random_chance;

          while (
            belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
          ) {
            nouvelle_colonne++;
            messageReturn = console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
          }
      
        }
        else {
          console.log(`Le cycliste ne doit pas changer de case.`);
          messageReturn = messageReturn + " <br> Le cycliste ne doit pas changer de case.";
        }
      }
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);
    }
    // Si case invalide, provoque chute
    else {
      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est invalide.`);
      messageReturn = this.chute(nouvelle_ligne, this.numero, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(1);
    }


    console.log(`Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);

    return messageReturn;

  }

  chute(nouvelle_ligne, numero, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    const ligne_chute = nouvelle_ligne;
    const nums_chutes = [numero];

    console.log(`Chute de tous les cyclistes de la ligne ${ligne_chute} !`);
    belgique_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero) });
    italie_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero) });
    hollande_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero) });
    allemagne_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero) });

    console.log(`Les cyclistes suivants sont tombés: ${nums_chutes.join(', ')}`);

    return "Chute de tous les cyclistes de la ligne " + ligne_chute + " ! Les cyclistes suivants sont tombés: " + nums_chutes.join(', ');

  }



  toString() {
    return "Nom : " + this.nom + " | Posiiton : " + this.pos
  }


}

export default Cycliste;