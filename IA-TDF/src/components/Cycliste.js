import Position from './Position';

class Cycliste {
  constructor(numero,nom) {
    this.nom = nom;
    this.numero = numero;
    this.position = new Position(0, 0);
    this.fin_circuit = false;
    this.secondesCompteur = 102;
  }

  /**
   * 
   * @returns le numero du cycliste.
   */
  getNumero() { return this.numero; }

  getPosition() { return this.position; }

  getPosition2() { return {nom: this.nom, numero: this.numero, ligne: this.position.getLigne(), colonne: this.position.getColonne(), position: this.position }; }

  getPosition3() { return `${this.position.getLigne()},  ${this.position.getColonne()}`; }



  /**
   * 
   * @returns {Boolean} true si le circuit est fini, false sinon
   */
  getFinCircuit() { return this.fin_circuit; }

  /**
   * Ajoute des secondes à this.secondesCompteur.
   * @param {number} numero nombre de secondes à ajouter
   */
  setSecondesCompteurAdd(numero) { 
    this.secondesCompteur = this.secondesCompteur + numero;
    //console.log(this);
  }

  /**
   * Enlève des secondes à this.secondesCompteur.
   * @param {number} numero nombre de secondes à enlever
   */
  setSecondesCompteurMinus(numero) { 
    this.secondesCompteur = this.secondesCompteur - numero;
    //console.log(this);
  }

  /**
   * @returns {number} nombre de seconde du cycliste.
   */
  getSecondesCompteur() { 
    return this.secondesCompteur;
  }


  /**
   * Affiche la position du joueur
   */
  afficher_position() {
    console.log(`Cycliste ${this.numero} : [${this.position.getLigne()},${this.position.getColonne()}]`);
  }


   /**
   * Vérifie si la case est indisponible et ajuste la nouvelle ligne si nécessaire.
   * @param {Plateau} plateau - L'instance du plateau.
   * @param {number} nouvelle_ligne - La nouvelle ligne de la position du cycliste.
   * @param {number} nouvelle_colonne - La nouvelle colonne de la position du cycliste.
   * @returns {number} - La nouvelle ligne ajustée si la case était indisponible.
   */
   checkIndisponibleCase(plateau,ancienne_ligne, nouvelle_ligne, nouvelle_colonne) {
    do {
      console.log(nouvelle_ligne);
      console.log(nouvelle_colonne);
      if (plateau.check_case_indisponible(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne))) {
        console.log("Ligne " + nouvelle_ligne + " indisponible, +1");
        nouvelle_ligne++;
      } else {
        break;
      }
    } while (ancienne_ligne !== nouvelle_ligne);

  
    return nouvelle_ligne;
  }


  deplacement(choixCarte,choixColonne, plateau, cycliste_chute,cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    var ancienne_ligne = this.position.getLigne();
    var nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
    var nouvelle_colonne = choixColonne;
    var messageReturn = "";
    var circuit1 = false;
    var circuit2 = false;
    var circuit3 = false;
    var circuit4 = false;

    // Check circuit secondaire
     // Check si la position du cycliste actuel se trouve entre la ligne 24 et 39. Défini ensuite son circuit.
     if(this.position.getLigne() >= 24 && this.position.getLigne() <= 39 ) {
      if(this.position.getColonne() == 1 || this.position.getColonne() == 2) {
        circuit1 = true;
      }
      if(this.position.getColonne() == 4) {
        circuit2 = true;
        if(nouvelle_ligne <= 39) {
          nouvelle_colonne = 4;
        }
      }
      else {
        circuit1 = false;
        circuit2 = false;
      }
    }

     // Check si la position du cycliste actuel se trouve entre la ligne 89 et 102. Défini ensuite son circuit.
     if(this.position.getLigne() >= 89 && this.position.getLigne() <= 102 ) {
      if(this.position.getColonne() == 1) {
        circuit3 = true;
        if(nouvelle_ligne <= 102) {
          nouvelle_colonne = 1;
        }
      }
      if(this.position.getColonne() == 3) {
        circuit4 = true;
        if(nouvelle_ligne <= 102) {
          nouvelle_colonne = 3;
        }
      }
      else {
        circuit3 = false;
        circuit4 = false;
      }
    }

    // Check si case indisponible 
    nouvelle_ligne = this.checkIndisponibleCase(plateau,ancienne_ligne, nouvelle_ligne, nouvelle_colonne);
    
    
    // Check si autre joueur case, si oui +1 colonne
    var first = true;

    //console.log("belgique_positions", JSON.stringify(belgique_positions));
    //console.log("italie_positions", JSON.stringify(italie_positions));
    //console.log("hollande_positions", JSON.stringify(hollande_positions));
    //console.log("allemagne_positions", JSON.stringify(allemagne_positions));

    nouvelle_ligne = parseInt(nouvelle_ligne);
    nouvelle_colonne = parseInt(nouvelle_colonne);

    while (
      belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
    ) {
      if (first) {
        first = false;
        nouvelle_colonne = 1;
      }
      if (circuit1 && nouvelle_colonne === 2) {
        break;
      }
      if (circuit2 && nouvelle_colonne === 4) {
        break;
      }
      if (circuit3 && nouvelle_colonne === 1) {
        break;
      }
      if (circuit4 && nouvelle_colonne === 3) {
        break;
      }
      nouvelle_colonne++;
      console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
      messageReturn = "Un cycliste est déjà présent sur la case --> déviation à la case à côté";
    }

    // Check si case chance
    const case_chance = plateau.check_case_chance_plateau(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne));

    if (case_chance) {
      messageReturn = messageReturn + " Le cycliste est tombé sur une case chance";
      console.log("case chance");
      const random_chance = Math.floor(Math.random() * 7) - 3;
      if (random_chance < 0) {
        console.log(`Le cycliste recule de ${Math.abs(random_chance)} cases.`);
        messageReturn = messageReturn + " Le cycliste recule de " + Math.abs(random_chance) + " case(s).";
        nouvelle_ligne = nouvelle_ligne - Math.abs(random_chance);
        nouvelle_colonne = 1;

      }
      else if (random_chance > 0) {
        console.log(`Le cycliste avance de ${random_chance} cases.`);
        messageReturn = messageReturn + " Le cycliste avance de " + random_chance + " case(s).";
        nouvelle_ligne = nouvelle_ligne + random_chance;
        nouvelle_colonne = 1;
    
      }
      else {
        console.log(`Le cycliste ne doit pas changer de case.`);
        messageReturn = messageReturn + " Le cycliste ne doit pas changer de case.";
      }

      // Check si case indisponible 
      nouvelle_ligne = this.checkIndisponibleCase(plateau,ancienne_ligne, nouvelle_ligne, nouvelle_colonne);

      /*
      console.log("nouvelle_ligne "+ typeof nouvelle_ligne);
      console.log("nouvelle_colonne "+ typeof nouvelle_colonne);

      nouvelle_ligne = parseInt(nouvelle_ligne);
      nouvelle_colonne = parseInt(nouvelle_colonne);

      console.log("belgique_positions", JSON.stringify(belgique_positions));
      console.log("italie_positions", JSON.stringify(italie_positions));
      console.log("hollande_positions", JSON.stringify(hollande_positions));
      console.log("allemagne_positions", JSON.stringify(allemagne_positions));*/

      // Check si autre joueur case, si oui +1 colonne
      while (
        belgique_positions.find(pos => pos.ligne === nouvelle_ligne  && pos.colonne === nouvelle_colonne) !== undefined ||
        italie_positions.find(pos => pos.ligne === nouvelle_ligne  && pos.colonne === nouvelle_colonne) !== undefined ||
        hollande_positions.find(pos => pos.ligne === nouvelle_ligne  && pos.colonne === nouvelle_colonne) !== undefined ||
        allemagne_positions.find(pos => pos.ligne === nouvelle_ligne  && pos.colonne === nouvelle_colonne) !== undefined
      ) {
        if (circuit1 && nouvelle_colonne === 2) {
          break;
        }
        if (circuit2 && nouvelle_colonne === 4) {
          break;
        }
        if (circuit3 && nouvelle_colonne === 1) {
          break;
        }
        if (circuit4 && nouvelle_colonne === 3) {
          break;
        }
        nouvelle_colonne++;
        console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
        messageReturn = messageReturn + "Un cycliste est déjà présent sur la case --> déviation à la case à côté";
      }
    }



    //Check si case valide 
    if (plateau.check_position_plateau(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne))) {
      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est valide.`);


      this.position.setLigne(nouvelle_ligne);
      this.position.setColonne(nouvelle_colonne);


      // Check si ligne d'arrivé
      if (nouvelle_ligne >= plateau.getNbLignes()) {
        console.log(`Le cycliste ${this.numero} a terminé le circuit !`);
        this.fin_circuit = true;
        console.log(this);
        cyclistes_finis.push(this);
      }


    }
    //Check si case supplementaire
    else if(plateau.check_case_supplementaire_plateau(parseInt(nouvelle_ligne),parseInt(nouvelle_colonne))){

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
    // Chute
    else {
      messageReturn = this.chute(nouvelle_ligne, this.numero,cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions);
       this.position.setLigne(nouvelle_ligne);
       this.position.setColonne(1);
    }


    // Affichage console
    console.log(`Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`);
    messageReturn = messageReturn + ` <br> Le cycliste ${this.numero} se déplace de ${choixCarte} case. Nouvelle position :  (  ${this.position.getLigne()} , ${this.position.getColonne()} ) .`;
    return messageReturn;

  }

  /*
  deplacement(choixCarte,choixColonne, plateau, cycliste_chute,cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    var nouvelle_ligne = this.position.getLigne() + parseInt(choixCarte);
    var ancienne_ligne = this.position.getLigne();
    var nouvelle_colonne = choixColonne;
    var messageReturn = "";
    var circuit1 = false;
    var circuit2 = false;
    var circuit3 = false;
    var circuit4 = false;

    // Check si la position du cycliste actuel se trouve entre la ligne 24 et 39. Défini ensuite son circuit.
    if(this.position.getLigne() >= 24 && this.position.getLigne() <= 39 ) {
      if(this.position.getColonne() == 1 || this.position.getColonne() == 2) {
        circuit1 = true;
      }
      if(this.position.getColonne() == 4) {
        circuit2 = true;
        if(nouvelle_ligne <= 39) {
          nouvelle_colonne = 4;
        }
      }
      else {
        circuit1 = false;
        circuit2 = false;
      }
    }

     // Check si la position du cycliste actuel se trouve entre la ligne 89 et 102. Défini ensuite son circuit.
     if(this.position.getLigne() >= 89 && this.position.getLigne() <= 102 ) {
      if(this.position.getColonne() == 1) {
        circuit3 = true;
        if(nouvelle_ligne <= 102) {
          nouvelle_colonne = 1;
        }
      }
      if(this.position.getColonne() == 3) {
        circuit4 = true;
        if(nouvelle_ligne <= 102) {
          nouvelle_colonne = 3;
        }
      }
      else {
        circuit3 = false;
        circuit4 = false;
      }
    }

 
    // Check si case indisponible
    do {
      if (plateau.check_case_indisponible(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne))) {
        console.log("Ligne " + nouvelle_ligne + " indisponible, +1");
        nouvelle_ligne++;
      }
      else{
        break;
      }
    } while (ancienne_ligne != nouvelle_ligne);
    

    // Check si case occupé par un cycliste, si oui place cherche une colonne disponible.
    var first = true;
  
    while (
      belgique_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      italie_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      hollande_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne) ||
      allemagne_positions.find(pos => pos.ligne === nouvelle_ligne && pos.colonne === nouvelle_colonne)
    ) {
      if(first) {
        first=false;
        nouvelle_colonne = 1;
      }
      if(circuit1 && nouvelle_colonne === 2) {
        break;
      }
      if(circuit2) {
        nouvelle_colonne = 4;
        break;
      }
      nouvelle_colonne++;
      console.log("Un cycliste est déjà présent sur la case --> déviation à la case à côté");
      messageReturn = "Un cycliste est déjà présent sur la case --> déviation à la case à côté";
    }


    //Check si case valide
    if (plateau.check_position_plateau(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne))) {

      console.log(`La position ${nouvelle_ligne, nouvelle_colonne} est valide.`);

      const case_chance = plateau.check_case_chance_plateau(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne));

      // si cycliste est sur une case chance 
      if (case_chance) {
        messageReturn = messageReturn + " Le cycliste est tombé sur une case chance";
        console.log("case chance");
        const random_chance = Math.floor(Math.random() * 7) - 3;
        if (random_chance < 0) {
          console.log(`Le cycliste recule de ${Math.abs(random_chance)} cases.`);
          messageReturn = messageReturn + " Le cycliste recule de " + Math.abs(random_chance) + " case(s).";
          nouvelle_ligne = nouvelle_ligne - Math.abs(random_chance);
          nouvelle_colonne = 1;

        }
        else if (random_chance > 0) {
          console.log(`Le cycliste avance de ${random_chance} cases.`);
          messageReturn = messageReturn + " Le cycliste avance de " + random_chance + " case(s).";
          nouvelle_ligne = nouvelle_ligne + random_chance;
          nouvelle_colonne = 1;
      
        }
        else {
          console.log(`Le cycliste ne doit pas changer de case.`);
          messageReturn = messageReturn + "  Le cycliste ne doit pas changer de case.";
        }
        
      }

      // Check si case indisponible
      do {
        if (plateau.check_case_indisponible(parseInt(nouvelle_ligne), parseInt(nouvelle_colonne))) {
          console.log("Ligne " + nouvelle_ligne + " indisponible, +1");
          nouvelle_ligne++;
        }
        else{
          break;
        }
      } while (ancienne_ligne != nouvelle_ligne);

      //TODO: Check si case occupé par un cycliste, si oui place cherche une colonne disponible.
      console.log("Ligne " + nouvelle_ligne + " colonne "+ nouvelle_colonne);
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
    //Check si case supplementaire
    else if(plateau.check_case_supplementaire_plateau(parseInt(nouvelle_ligne),parseInt(nouvelle_colonne))){

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

  }*/

  
  chute(nouvelle_ligne, numero,cycliste_chute, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {
    const ligne_chute = nouvelle_ligne;
    const nums_chutes = [numero];
    cycliste_chute.push(this);

    console.log(`Chute de tous les cyclistes de la ligne ${ligne_chute} !`);
    // Check la position de tout les cycliste, si présent sur la ligne chuté, ils sont ajoutés dans la liste cycliste_chute.
    belgique_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos); });
    italie_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos);  });
    hollande_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos); });
    allemagne_positions.forEach(pos => { if (pos.ligne === ligne_chute) nums_chutes.push(pos.numero); if (pos.ligne === ligne_chute) cycliste_chute.push(pos);  });

    // Fixe la colonne des cyclistes tombés sur 0
    cycliste_chute.forEach(cycliste => {
      //console.log(cycliste);
      cycliste.position.setColonne(1);
      //console.log(cycliste);
    });

    console.log(`Les cyclistes suivants sont tombés: ${nums_chutes.join(', ')}`);

    return "Chute de tous les cyclistes de la ligne " + ligne_chute + " ! Les cyclistes suivants sont tombés: " + nums_chutes.join(', ')+ " Au prochain tour ils seront remis à la colonne 1";

  }


  toString() {
    return "Nom : " + this.nom + " | Position : " + this.position;
  }





}

export default Cycliste;