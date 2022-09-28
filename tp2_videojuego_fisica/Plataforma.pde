class Plataforma extends FBox {

  int tamBloques, cincuentaPX;
  float x_bolsa, y_bolsa;
  float x_bloque, y_bloque;
  float x_inicio, y_inicio;
  boolean derecha;
  PImage choco;

  Plataforma(float w, float h) {
    super(w, h);
    cincuentaPX = 50;
    derecha = false;
    choco = loadImage("chocolate.png");
    x_inicio = (width/2-(cincuentaPX*2)-25);
    y_inicio = 775;
  }

  void iniciarBloquesFijos(float x, float y, float r, PImage bloque) {
    attachImage(bloque);
    setName("fijo");
    setGrabbable(false);
    setPosition(x, y - cincuentaPX/2);
    setRestitution(r);
    setStatic(true);
    mundo.add(this);
  }

  void iniciarBloquesMovibles(float x, float y) {
    attachImage(choco);
    setName("movible");
    x_bloque = x;
    y_bloque = y - cincuentaPX/2;
    setPosition(x_bloque, y_bloque);
    setRestitution(0.2);
    setStatic(true);
    mundo.add(this);
  }
  void iniciarBloqueInicio() {
    attachImage(choco);
    setPosition(x_inicio, y_inicio);
    setRestitution(0.2);
    setStatic(true);
    inicio.add(this);
  }
  void iniciarBolsa(float x, float y, PImage img) {
    attachImage(img);
    x_bolsa = x;
    y_bolsa = y;
    derecha = false;
    setGrabbable(false);
    setName("bolsa");
    setPosition(x, y);
    setRestitution(0);
    mundo.add(this);
  }
  void iniciarBolsa_(float x, float y, PImage img) {
    attachImage(img);
    x_bolsa = x;
    derecha = false;
    setGrabbable(false);
    setName("b_inicio");
    setPosition(x, y);
    setRestitution(0);
    inicio.add(this);
  }
  void iniciarPiso(float x, float y) {
    setPosition(x, y);
    setName("piso");
    setGrabbable(false);
    setStatic(true);
    setNoFill();
    setNoStroke();
    mundo.add(this);
    inicio.add(this);
  }
  void iniciarBorde(float x, float y) {
    setPosition(x, y);
    setName("borde");
    setGrabbable(false);
    setStatic(true);
    setRestitution(0.7);
    setNoFill();
    setNoStroke();
    mundo.add(this);
    inicio.add(this);
  }
  void moverBolsa() {
    if (getX() > x_bolsa + 450) {
      derecha = false;
    } else if (getX() < x_bolsa - 450) {
      derecha = true;
    }
    if (derecha) {
      setVelocity(150, getVelocityY());
    } else {
      setVelocity(-150, getVelocityY());
    }
  }
  void resetearBolsa(){
    bolsa.setPosition(x_bolsa, y_bolsa); 
  }
  void resetearBloques(){
    setPosition(x_bloque, y_bloque);
  }
  void resetearBloqueInicio(){
    setPosition(x_inicio, y_inicio);
  }
}
