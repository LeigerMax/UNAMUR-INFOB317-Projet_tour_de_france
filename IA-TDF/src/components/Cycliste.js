import Position from './Position';

class Cycliste {
  constructor(numero,nom) {
    this.nom = nom;
    this.numero = numero;
    this.position = new Position(0, 0);
    this.fin_circuit = false;
    this.secondesCompteur = 102;
  }

  getNumero() { return this.numero; }

  getPosition() { return this.position; }

  getPosition2() { return {nom: this.nom, numero: this.numero, ligne: this.position.getLigne(), colonne: this.position.getColonne() }; }

  getPosition3() { return `${this.position.getLigne()},  ${this.position.getColonne()}`; }

  getFinCircuit() { return this.fin_circuit; }

  setSecondesCompteurAdd(numero) { 
    this.secondesCompteur = this.secondesCompteur + numero;
    console.log(this);
  }

  setSecondesCompteurMinus(numero) { 
    this.secondesCompteur = this.secondesCompteur - numero;
    console.log(this);
  }

  getSecondesCompteur() { 
    return this.secondesCompteur;
  }



  afficher_position() {
    console.log(`Cycliste ${this.numero} : [${this.position.getLigne()},${this.position.getColonne()}]`);
  }


  deplacement(choixCarte, plateau, cycliste_chute,cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    var nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
    var ancienne_ligne = this.position.getLigne();
    var nouvelle_colonne = 1;
    var messageReturn = "";



    // Check si case indisponible 
    while(ancienne_ligne != nouvelle_ligne) {
      if(plateau.check_case_indisponible(ancienne_ligne,nouvelle_colonne)){
        nouvelle_ligne++;
        console.log("Ligne " +nouvelle_ligne+" indisponible, +1");
      }
      ancienne_ligne++
    }

    
    while (
      belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
    ) {
      nouvelle_colonne++;
      console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
      messageReturn = "Un cycliste est déjà présent sur la case --> déviation à la case à côté";
    }


    //Check si case valide
    if (plateau.check_position_plateau(nouvelle_ligne, nouvelle_colonne)) {
      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est valide.`);

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
          nouvelle_colonne = 1;

          while (
            belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
          ) {
            nouvelle_colonne++;
            console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
          }
      
        }
        else if (random_chance > 0) {
          console.log(`Le cycliste avance de ${random_chance} cases.`);
          messageReturn = messageReturn + " <br> Le cycliste avance de " + random_chance + " case(s).";
          nouvelle_ligne = nouvelle_ligne + random_chance;
          nouvelle_colonne = 1;

          while (
            belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
            allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
          ) {
            nouvelle_colonne++;
            console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
          }
      
        }
        else {
          console.log(`Le cycliste ne doit pas changer de case.`);
          messageReturn = messageReturn + " <br> Le cycliste ne doit pas changer de case.";
        }
      }
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);

      if (nouvelle_ligne >= plateau.getNbLignes()) {
        console.log(`Le cycliste ${this.numero} a terminé le circuit !`);
        this.fin_circuit = true;
        console.log(this);
        cyclistes_finis.push(this);
      }
  

    }
    //Check si case supplementaire
    else if(plateau.check_case_supplementaire_plateau(nouvelle_ligne,nouvelle_colonne)){

      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);
      this.setSecondesCompteurAdd(nouvelle_ligne);

      console.log(`Le cycliste ${this.numero} a terminé le circuit !`);
      console.log(this);
      this.fin_circuit = true;
      cyclistes_finis.push(this);
      const secondEnMoins = plateau.getNbPointMinus(nouvelle_ligne,nouvelle_colonne);
      this.setSecondesCompteurMinus(secondEnMoins);
    }
    //Check si case invalide
    else {
      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est invalide.`);

      messageReturn = this.chute(nouvelle_ligne, this.numero,cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(1);
    }

    console.log(`Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);
    messageReturn = messageReturn + ` <br> Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`;
    return messageReturn;

  }

  chute(nouvelle_ligne, numero,cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    const ligne_chute = nouvelle_ligne;
    const nums_chutes = [numero];
    cycliste_chute.push(this);

    console.log(`Chute de tous les cyclistes de la ligne ${ligne_chute} !`);
    belgique_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos); });
    italie_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos);  });
    hollande_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos); });
    allemagne_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos);  });


    console.log(`Les cyclistes suivants sont tombés: ${nums_chutes.join(', ')}`);

    return "Chute de tous les cyclistes de la ligne " + ligne_chute + " ! Les cyclistes suivants sont tombés: " + nums_chutes.join(', ');

  }



  toString() {
    return "Nom : " + this.nom + " | Position : " + this.pos;
  }


}

export default Cycliste;