class Juego {

  int cont;
  int nivel;

  ArrayList<String[]> retos;
  ArrayList<String> verdades;

  Persona[] personas;

  Juego(ArrayList<String[]> retos, ArrayList<String> verdades, Persona[] mujeres, Persona[] hombres) {
    this.retos = retos;
    this.verdades = verdades;

    this.personas = asignarProv(hombres, mujeres);

    cont = 0; 
    nivel = 0;
  }

  Persona[] asignarProv(Persona[] hombres, Persona[] mujeres) {    
    Persona[] personas = new Persona[hombres.length + mujeres.length];

    for (int i = 0; i < hombres.length; i++) {
      Persona[] probI = new Persona[3];
      if (i == 0) {
        probI[0] = mujeres[0];
        probI[1] = mujeres[1];
        probI[2] = hombres[1];
      } else if (i == hombres.length - 1) {
        probI[0] = mujeres[mujeres.length - 1];
        probI[1] = mujeres[mujeres.length - 2];
        probI[2] = hombres[hombres.length - 2];
      } else {
        probI[0] = hombres[i - 1];
        probI[1] = mujeres[i];
        probI[2] = hombres[i + 1];
      }
      hombres[i].agregarProb(probI);
      personas[i] = hombres[i];
    }

    for (int i = 0; i < mujeres.length; i++) {
      Persona[] probI = new Persona[3];
      if (i == 0) {
        probI[0] = hombres[0];
        probI[1] = hombres[1];
        probI[2] = mujeres[1];
      } else if (i == mujeres.length - 1) {
        probI[0] = hombres[hombres.length - 1];
        probI[1] = hombres[hombres.length - 2];
        probI[2] = mujeres[mujeres.length - 2];
      } else {
        probI[0] = mujeres[i - 1];
        probI[1] = hombres[i];
        probI[2] = mujeres[i + 1];
      }
      mujeres[i].agregarProb(probI);
      personas[hombres.length + i] = mujeres[i];
    }

    printArray(personas);
    return personas;
  }


  Persona[] personas() {
    return personas;
  }

  String jugar(boolean verdad) {    
    if (cont > 20) {
      cont = 0;
      nivel += (nivel == 2)? 0 : 1;
    }
    String[] a;

    if (verdad) a = verdades.toArray(new String[verdades.size()]);
    else {
      float r = random(0, 1);
      a = (r > 0.3)? retos.get(nivel) : retos.get(3);
    }

    int id = (int) random(0, this.personas.length);
    int id1 = (int) random(0, 3);

    Persona personaA = this.personas[id];
    Persona personaB = personaA.getProv(id1);

    int b = (int) random(0, a.length);

    String acc = a[b].toString();   

    int indexA = acc.indexOf("1");
    int indexB = acc.indexOf("2");
    
    if(personaA.toString().equals(personaB.toString())) return null;

    if (indexA == -1) {
      cont++;
      return acc;
    } else {
      boolean isP = personaA.isRep(nivel, b);
      if (isP) { 
        personaA.rep(nivel, b);
        acc = acc.replace("1", personaA.toString());
      } else return null;
    }

    if (indexB == -1) {
      cont++;
      return acc;
    } else acc = acc.replace("2", personaB.toString());

    cont++;
    return acc;
  }
}