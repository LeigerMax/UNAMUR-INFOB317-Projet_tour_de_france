
class Position {
    constructor(ligne, colonne) {
      this.ligne = ligne;
      this.colonne = colonne;
    }
  
    getLigne() {
      return this.ligne;
    }

    getColonne() {
      return this.colonne;
    }

    
    setLigne(ligne) {
      this.ligne = ligne;
    }

    setColonne(colonne) {
      this.colonne = colonne;
    }

    
  }
  
  export default Position;