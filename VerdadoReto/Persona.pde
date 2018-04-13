class Persona {

  String nombre;

  int[] rep1;
  int[] rep2;
  int[] rep3;

  Persona[] personas;

  Persona(String nombre, int ret1, int ret2, int ret3) {
    this.nombre = nombre;

    rep1 = new int[ret1];
    rep2 = new int[ret2];
    rep3 = new int[ret3];
  }

  void rep(int tipo, int indice) {
    switch(tipo) {
    case 0: 
      rep1[indice]++;
      break;
    case 1: 
      rep2[indice]++;
      break;
    case 2: 
      rep3[indice]++;
      break;
    }
  }
  
  boolean isRep(int tipo, int indice){
    switch(tipo) {
    case 0: 
      return rep1[indice] < 2;
    case 1: 
      return rep2[indice] < 2;
    case 2: 
      return rep3[indice] < 2;
    default: 
      return false;
    }
  }
  
  void agregarProb(Persona[] personas){
    this.personas = personas;
  }
  
  Persona getProv(int id){
    return this.personas[id];
  }
  
  String toString(){
    return nombre;
  }
}