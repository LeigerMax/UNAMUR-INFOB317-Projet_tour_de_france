
class Position {
  constructor(ligne, colonne) {
    this.ligne = ligne;
    this.colonne = colonne;
  }

  /**
   * 
   * @returns ligne
   */
  getLigne() {
    return this.ligne;
  }

  /**
   * 
   * @returns colonne
   */
  getColonne() {
    return this.colonne;
  }


  /**
   * Setter ligne
   * 
   * @param {*} ligne 
   */
  setLigne(ligne) {
    this.ligne = ligne;
  }

  /**
   * Setter colonne
   * 
   * @param {*} colonne 
   */
  setColonne(colonne) {
    this.colonne = colonne;
  }


}

export default Position;