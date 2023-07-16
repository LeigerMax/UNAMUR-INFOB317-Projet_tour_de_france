import Cycliste from "./Cycliste";
import Jeu from "./Jeu";

class Joueur {
  constructor(nom) {
    this.nom = nom;
    this.cartes = [];
    this.cyclistes = [];
    this.points = 0;
  }

  /**
   * 
   * @returns {string} le nom du joueur
   */
  getNom() { return this.nom; }

  /**
   * 
   * @returns {number} les points du joueur
   */
  getPoints() { return this.points; }

  /**
   * Calcul les points du joueur.
   */
  calcul_points() {
    let totalSeconds = 0;
    for (let i = 0; i < this.cyclistes.length; i++) {
      totalSeconds += this.cyclistes[i].getSecondesCompteur();
    }
    this.points = totalSeconds;
  }

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

  getNumCycliste(numero) {
    const cycliste = this.cyclistes.find(c => c.getNumero() === numero);
    if (!cycliste) {
      return null;
    }
    return cycliste.getNumero();
  }

  getCyclisteTest(numero) {
    return this.cyclistes.find(cycliste => cycliste.getNumero() === numero) || null;
  }

  /**
   * Ajoute des secondes aux cyclistes
   * 
   * @param {number} choixCycliste numéro du cycliste
   * @param {number} numero nombre de secondes à ajouter
   */
  secondes_acc(choixCycliste,numero){
    const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);
    //console.log(cycliste);
    cycliste.setSecondesCompteurAdd(numero);
  }


  /**
   * Ajoute un cycliste au joueur
   * 
   * @param {*} cycliste 
   * @returns 
   */
  ajouter_cycliste(cycliste) {
    // Vérifier si le joueur a déjà le maximum de cyclistes
    if (this.cyclistes.length >= 3) {
      //console.log("Le joueur " + this.nom + " a déjà le maximum de cyclistes.");
      return;
    }

    // Ajouter le cycliste à la liste des cyclistes du joueur
    this.cyclistes.push(cycliste);

   // console.log("Le cycliste " + cycliste.numero + " a été ajouté à la liste des cyclistes du joueur " + this.nom + ".");
  }



  /**
   * Déplace le cycliste.
   * 
   * @param {number} choixCycliste numéro du cycliste jouer
   * @param {number} choixCarte numéro de la carte jouer
   * @param {Object} plateau 
   * @param {Array} cycliste_chute liste des cyclistes ayant chutés
   * @param {Array} cyclistes_finis liste des cyclistes ayant fini le circuit
   * @param {*} belgique_positions les positions de tout les cyclistes de Belgique
   * @param {*} italie_positions les positions de tout les cyclistes de Italie
   * @param {*} hollande_positions les positions de tout les cyclistes de Hollande
   * @param {*} allemagne_positions les positions de tout les cyclistes de Allemagne
   * @returns 
   */
  deplacer_cycliste(choixCycliste, choixCarte,choixColonne, plateau,cycliste_chute,cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions) {

    // Trouver le cycliste dans la liste des cyclistes du joueur
    const cycliste = this.cyclistes.find(c => c.getNumero() === choixCycliste);

    // Si cycliste pas présent
    if (!cycliste) {
      console.log("Le cycliste " + choixCycliste + " n'appartient pas à la liste des cyclistes du joueur " + this.nom + ".");
      return;
    }

    // Appel la méthode deplacement() de Cycliste.
    const messageReturn = cycliste.deplacement(choixCarte,choixColonne, plateau, cycliste_chute , cyclistes_finis, belgique_positions, italie_positions, hollande_positions, allemagne_positions);

    //console.log(`Le joueur ${this.nom} a déplacé le cycliste ${choixCycliste} avec la carte ${choixCarte}.`);

    return messageReturn;

  }

  /**
   * Récupère les position des cyclistes du joueur
   * 
   * @returns {*} la positition des cyclistes du joueur
   */
  get_positions_cyclistes() {
    this.position_all_cycliste = [];
    this.cyclistes.forEach(cycliste => {
      this.position_all_cycliste.push(cycliste.getPosition2());
    });
    return this.position_all_cycliste;
  }

  /**
   * Récupère la position d'un cycliste du joueur
   * 
   * @param {number} cyclisteNombre numéro du cycliste 
   * @returns {*} la positition u cycliste.
   */
  get_position_cycliste(cyclisteNombre) {
    this.positionDuCycliste = null;
    this.cyclistes.forEach(cycliste => {
      if (cycliste.numero === cyclisteNombre) {
        this.positionDuCycliste = cycliste.getPosition3();
      }
    });
    return this.positionDuCycliste;
  }


  /******************************
   *                            *
   *         Cartes             *
   *                            *
   ******************************/

  /**
   * Ajoute les cartes au joueur.
   * 
   * @param {*} cartes 
   */
  recevoir_cartes(cartes) {
    this.cartes = this.cartes.concat(cartes);
  }

  /**
   * Joue une carte.
   * 
   * @param {number} choixCarte à jouer
   */
  jouer_carte(choixCarte) {
    // Trouver l'index de la carte dans le tableau de cartes du joueur
    const index = this.cartes.findIndex(carte => carte.valeur === parseInt(choixCarte));
    var carteSupp;
    if (index !== -1) {
      // Supprimer la carte du tableau de cartes du joueur
      carteSupp = this.cartes[index];
      this.cartes.splice(index, 1);

    }
    return carteSupp;
  }


  /**
   * 
   * @returns {*}
   */
  getCarte() {
    const numeros = [];

    for (const carte of this.cartes) {
      numeros.push(carte);
    }
    return numeros;
  }

  

}

export default Joueur;