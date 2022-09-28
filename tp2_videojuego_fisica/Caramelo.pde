class Caramelo extends FCircle {

  PImage [] caramelo;
  int cantidadImagenes = 4;

  Caramelo(float r) {
    super(r);

    caramelo = new PImage [cantidadImagenes];

    for (int i = 0; i < cantidadImagenes; i ++) {
      caramelo[i] = loadImage("candy" + nf(i, 2) + ".png");
    }
  }

  void iniciarCaramelo(float x, float y) {
    setPosition(x, y);
    addImpulse(0, 6000);
    float porcentaje = random(100);
    if (porcentaje > 0 && porcentaje < 25) {
      attachImage(caramelo[0]);
      setDensity(0.2);
      setName("caramelo_rosa");
    } else if (porcentaje > 25 && porcentaje < 50) {
      attachImage(caramelo[1]);
      setDensity(0.4);
      setName("caramelo_violeta");
    } else if (porcentaje > 50 && porcentaje < 75) {
      attachImage(caramelo[2]);
      setDensity(0.7);
      setName("caramelo_amarillo");
    } else if (porcentaje > 75) {
      attachImage(caramelo[3]);
      setDensity(1);
      setName("caramelo_celeste");
    }
    mundo.add(this);
  }
  void dibujarCarameloInicio(float x, float y) {
    setPosition(x, y);
    setGrabbable(false);
    setRestitution(0.5);
    addImpulse(0, 6000);
    setDensity(0.2);
    setName("c_inicio");
    float porcentaje = random(100);
    if (porcentaje > 0 && porcentaje < 25) {
      attachImage(caramelo[0]);
    } else if (porcentaje > 25 && porcentaje < 50) {
      attachImage(caramelo[1]);
    } else if (porcentaje > 50 && porcentaje < 75) {
      attachImage(caramelo[2]);
    } else if (porcentaje > 75) {
      attachImage(caramelo[3]);
    }
    inicio.add(this);
  }
  void resetearCaramelos() {
    mundo.remove(this);
  }
}
