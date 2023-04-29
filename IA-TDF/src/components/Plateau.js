
class Plateau {
    constructor() {
        this.nbLignes = 96;
        this.nbColonnes = 3;
        this.cases = [
            { debut: 1, fin: 8, nbColonnes: 3 },
            { debut: 9, fin: 18, nbColonnes: 2 },
            { debut: 19, fin: 22, nbColonnes: 3 },
            { debut: 22, fin: 35, nbColonnes: 3 },
            { debut: 36, fin: 72, nbColonnes: 2 },
            { debut: 72, fin: 75, nbColonnes: 1 },
            { debut: 76, fin: 83, nbColonnes: 2 },
            { debut: 84, fin: 96, nbColonnes: 2 },
        ];
        this.chances = [       
            {nbLignes: 9,  nbColonnes: 1 },
            {nbLignes: 10, nbColonnes: 1 },
            {nbLignes: 11, nbColonnes: 1 },
            {nbLignes: 12, nbColonnes: 1 },
            {nbLignes: 15, nbColonnes: 2 },
            {nbLignes: 16, nbColonnes: 2 },
            {nbLignes: 19, nbColonnes: 3 },
            {nbLignes: 21, nbColonnes: 3 },
            {nbLignes: 24, nbColonnes: 1 },
            {nbLignes: 26, nbColonnes: 1 },
            {nbLignes: 28, nbColonnes: 1 },
            {nbLignes: 30, nbColonnes: 1 },
            {nbLignes: 32, nbColonnes: 1 },
            {nbLignes: 34, nbColonnes: 1 },
            {nbLignes: 48, nbColonnes: 1 },
            {nbLignes: 57, nbColonnes: 2 },
            {nbLignes: 66, nbColonnes: 1 },
            {nbLignes: 66, nbColonnes: 2 },
            {nbLignes: 74, nbColonnes: 1 },
            {nbLignes: 90, nbColonnes: 2 },
          ];


    }

    getNbLignes() {
        return this.nbLignes;
      }

     // Vérifie si la position est dans une zone spéciale du plateau
    check_position_plateau(ligne, colonne) {
        for (const zone of this.cases) {
            if (ligne >= zone.debut && ligne <= zone.fin) {
                const nbColonnes = Array.isArray(zone.nbColonnes) ? zone.nbColonnes[colonne - 1] : zone.nbColonnes;
                if (colonne >= 1 && colonne <= nbColonnes) {
                    return true;
                }
            }
        }
        return false;
    }

    // Vérifie si le cycliste est sur une case chance
    check_case_chance_plateau(ligne, colonne) {
        for (const chance of this.chances) {
          if (chance.nbLignes === ligne && chance.nbColonnes >= colonne) {
            return true;
          }
        }
        return false;
      }

}

export default Plateau;