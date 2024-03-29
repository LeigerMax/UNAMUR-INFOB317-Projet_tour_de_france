
class Plateau {
    constructor() {
        this.nbLignes = 102;
        this.nbColonnes = 3;
        this.case = [
            { debut: 1, fin: 8, nbColonnes: 3 },
            { debut: 9, fin: 20, nbColonnes: 2 },
            { debut: 21, fin: 23, nbColonnes: 3 },
            { debut: 24, fin: 39, nbColonnes: 4 },
            { debut: 40, fin: 77, nbColonnes: 2 },
            { debut: 78, fin: 80, nbColonnes: 1 },
            { debut: 81, fin: 88, nbColonnes: 2 },
            { debut: 89, fin: 102, nbColonnes: 3 },
        ];
        this.caseSupplementaire = [
            { nbLignes: 103, nbColonnes: 3, nbPointMinus: 0 },
            { nbLignes: 104, nbColonnes: 3, nbPointMinus: 1 },
            { nbLignes: 105, nbColonnes: 3, nbPointMinus: 2 },
            { nbLignes: 106, nbColonnes: 3, nbPointMinus: 3 },
            { nbLignes: 107, nbColonnes: 3, nbPointMinus: 4 },
            { nbLignes: 108, nbColonnes: 3, nbPointMinus: 5 },
            { nbLignes: 109, nbColonnes: 3, nbPointMinus: 6 },
            { nbLignes: 110, nbColonnes: 3, nbPointMinus: 7 },
            { nbLignes: 111, nbColonnes: 3, nbPointMinus: 8 },
            { nbLignes: 112, nbColonnes: 3, nbPointMinus: 9 },
        ];
        this.caseChance = [
            { nbLignes: 9, nbColonnes: 1 },
            { nbLignes: 10, nbColonnes: 1 },
            { nbLignes: 11, nbColonnes: 1 },
            { nbLignes: 12, nbColonnes: 1 },
            { nbLignes: 15, nbColonnes: 2 },
            { nbLignes: 16, nbColonnes: 2 },
            { nbLignes: 19, nbColonnes: 3 },
            { nbLignes: 21, nbColonnes: 3 },
            { nbLignes: 24, nbColonnes: 1 },
            { nbLignes: 26, nbColonnes: 1 },
            { nbLignes: 28, nbColonnes: 1 },
            { nbLignes: 30, nbColonnes: 1 },
            { nbLignes: 32, nbColonnes: 1 },
            { nbLignes: 34, nbColonnes: 1 },
            { nbLignes: 48, nbColonnes: 1 },
            { nbLignes: 57, nbColonnes: 2 },
            { nbLignes: 66, nbColonnes: 1 },
            { nbLignes: 66, nbColonnes: 2 },
            { nbLignes: 74, nbColonnes: 1 },
            { nbLignes: 90, nbColonnes: 2 },
        ];
        this.caseIndisponible = [
            { nbLignes: 10, nbColonnes: 1 },
            { nbLignes: 12, nbColonnes: 1 },
            { nbLignes: 38, nbColonnes: 1 },
            { nbLignes: 38, nbColonnes: 2 },
            { nbLignes: 38, nbColonnes: 3 },
            { nbLignes: 39, nbColonnes: 0 },
            { nbLignes: 39, nbColonnes: 1 },
            { nbLignes: 39, nbColonnes: 2 },
            { nbLignes: 100, nbColonnes: 1 },
            { nbLignes: 100, nbColonnes: 2 },
            { nbLignes: 101, nbColonnes: 1 },
            { nbLignes: 101, nbColonnes: 2 },
        ];
    }

    /**
     * 
     * @returns {number} le nombre de lignes maximales
     */
    getNbLignes() {
        return this.nbLignes;
    }

    /**
     *  Vérifie si la position est dans une zone spéciale du plateau
     * 
     * @param {number} ligne 
     * @param {number} colonne 
     * @returns {boolean} true si position ok, false sinon
     */
    check_position_plateau(ligne, colonne) {
        for (const circuit of this.case) {
          if (ligne >= circuit.debut && ligne <= circuit.fin) {
            const nbColonnes = Array.isArray(circuit.nbColonnes) ? circuit.nbColonnes[colonne - 1] : circuit.nbColonnes;
            if (colonne >= 1 && colonne <= nbColonnes) {
              return true;
            }
          }
        }
        return false;
      }
      


    /**
     * Vérifie si le cycliste est sur une case chance
     * 
     * @param {number} ligne 
     * @param {number} colonne 
     * @returns {boolean} true si case chance, false sinon
     */
    check_case_chance_plateau(ligne, colonne) {
        for (const caseChance of this.caseChance) {
            if (caseChance.nbLignes === ligne && caseChance.nbColonnes >= colonne) {
                return true;
            }
        }
        return false;
    }


    /**
     * Vérifie si le cycliste est sur une case supplémentaire
     * 
     * @param {number} ligne 
     * @param {number} colonne 
     * @returns {boolean} true si case supplementaire, false sinon
     */
    check_case_supplementaire_plateau(ligne, colonne) {
        for (const caseSupplementaire of this.caseSupplementaire) {
            if (caseSupplementaire.nbLignes === ligne && caseSupplementaire.nbColonnes >= colonne) {
                return true;
            }
        }
        return false;
    }

    getNbPointMinus(ligne, colonne) {
        for (const caseSupplementaire of this.caseSupplementaire) {
            if (caseSupplementaire.nbLignes === ligne && caseSupplementaire.nbColonnes >= colonne) {
                return caseSupplementaire.nbPointMinus;
            }
        }
        return 0;
    }



    /**
     * Vérifie si le cycliste est sur une case indisponible
     * 
     * @param {number} ligne 
     * @param {number} colonne 
     * @returns {boolean} true si case indisponible, false sinon
     */
    check_case_indisponible(ligne, colonne) {
        for (const caseIndispo of this.caseIndisponible) {
          if (caseIndispo.nbLignes === ligne && caseIndispo.nbColonnes === colonne) {
            return true;
          }
        }
        return false;
      }
      
      

    /**
     * Renvoie le nombre de colonnes pour une ligne donnée
     * @param {number} ligne 
     * @returns {number} nombre de colonnes
     */
    getNbColonnes(ligne) {
        for (const circuit of this.case) {
            if (ligne >= circuit.debut && ligne <= circuit.fin) {
                return Array.isArray(circuit.nbColonnes) ? circuit.nbColonnes[0] : circuit.nbColonnes;
            }
        }
        for (const caseSup of this.caseSupplementaire) {
            if (ligne === caseSup.nbLignes) {
                return caseSup.nbColonnes;
            }
        }
        for (const caseChance of this.caseChance) {
            if (ligne === caseChance.nbLignes) {
                return caseChance.nbColonnes;
            }
        }
        return 0;
    }

    /**
     * Renvoie le nombre de colonnes pour une ligne et une colonne donnée 
     * 
     * @param {number} ligne 
     * @param {number} colonne
     * @returns {number} nombre de colonnes
     */
    getNbColonnesCircuit12(ligne, colonne) {
        if (colonne === 1 || colonne === 2) {
            return 2;
        } 
        else if (colonne === 4) {
            return 1;
        }
    }




}

export default Plateau;