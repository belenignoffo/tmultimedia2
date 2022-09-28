class Pendulo {

  FBox eje;
  FCircle chupetin;
  FDistanceJoint pendulo;

  float tam_eje, tam_chupetin, pendulo_length, y_chupetin;
  float chupetin_originalX, chupetin_originalY;
  PImage imagen_chupetin;
  boolean derecha;
  String nombre;

  Pendulo(String nombre) {
    tam_eje = 20;
    tam_chupetin = 70;
    pendulo_length = 90;
    imagen_chupetin = loadImage("chupetin.png");
    derecha = false;
    this.nombre = nombre;
  }

  void iniciarPendulo(float x, float y) {
    chupetin_originalX = x;
    chupetin_originalY = y;
    y_chupetin = (y + 100) - (tam_chupetin/2);
    eje = new FBox(tam_eje, tam_eje);
    eje.setGrabbable(false);
    eje.setPosition(x, y);
    eje.setStatic(true);
    eje.setSensor(true);
    eje.setNoFill();
    eje.setNoStroke(); 
    mundo.add(eje);

    chupetin = new FCircle(tam_chupetin);
    chupetin.setPosition(x, y_chupetin);
    chupetin.attachImage(imagen_chupetin);
    chupetin.setRestitution(1);
    chupetin.setName(nombre);
    mundo.add(chupetin);

    pendulo = new FDistanceJoint(eje, chupetin);
    pendulo.setLength(pendulo_length);
    mundo.add(pendulo);
  }

  void moverPendulo(float velocidad) {
    if (chupetin.getX() > chupetin_originalX + 90) {
      derecha = false;
    } else if (chupetin.getX() < chupetin_originalX - 90) {
      derecha = true;
    }
    if (derecha) {
      chupetin.setVelocity(velocidad, 0);
    } else {
      chupetin.setVelocity(-(velocidad), 0);
    }
  }

  void penduloQuieto() {
    if (derecha) {
      chupetin.setPosition(chupetin_originalX, y_chupetin);
      chupetin.setVelocity(0, 0);
    } else {
      chupetin.setPosition(chupetin_originalX, y_chupetin);
      chupetin.setVelocity(0, 0);
    }
  }
}
