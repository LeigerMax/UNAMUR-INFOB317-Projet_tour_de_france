
class Position {
  constructor(ligne, colonne) {
    this.ligne = ligne;
    this.colonne = colonne;
  }

  /**
   * 
   * @returns {number} ligne
   */
  getLigne() {
    return this.ligne;
  }

  /**
   * 
   * @returns {number} colonne
   */
  getColonne() {
    return this.colonne;
  }


  /**
   * Setter ligne
   * 
   * @param {number} ligne 
   */
  setLigne(ligne) {
    this.ligne = ligne;
  }

  /**
   * Setter colonne
   * 
   * @param {number} colonne 
   */
  setColonne(colonne) {
    this.colonne = colonne;
  }


}

export default Position;