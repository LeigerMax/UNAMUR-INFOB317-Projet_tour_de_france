
class Plateau{
    constructor(){
        this.nbLignes = 96;
        this.nbColonnes = 3;
        this.positionsSpeciales = [
            { debut: 1, fin: 8, nbColonnes: 3 },
            { debut: 9, fin: 18, nbColonnes: 2 },
            { debut: 19, fin: 22, nbColonnes: 3 },
            { debut: 22, fin: 35, nbColonnes: 3 },
            { debut: 36, fin: 72, nbColonnes: 2 },
            { debut: 72, fin: 75, nbColonnes: 1 },
            { debut: 76, fin: 83, nbColonnes: 2 },
            { debut: 84, fin: 96, nbColonnes: 2 },
          ];

    }

    check_position_plateau(ligne,colonne){
        // Vérifie si la position est dans une zone spéciale du plateau
        for (const zone of this.positionsSpeciales) {
            if (ligne >= zone.debut && ligne <= zone.fin) {
                const nbColonnes = Array.isArray(zone.nbColonnes) ? zone.nbColonnes[colonne - 1] : zone.nbColonnes;
                if (colonne >= 1 && colonne <= nbColonnes) {
                    return true;
                }
            }
        }
        return false;
    }

    

}

export default Plateau;