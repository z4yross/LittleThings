import javax.swing.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;

Juego juego;

String acc = "hola";
boolean vd = false;

void setup() {
  fullScreen();

  JSONObject json = loadJSONObject("https://svor-1c643.firebaseio.com/.json?auth=7AUgY1iRgxl6jgAbrFid6FX6Lhw4EJ7BcY4GaCIB");
  JSONArray a = json.getJSONArray("retos");
  String[] low = a.getJSONArray(1).getStringArray();
  String[] medium = a.getJSONArray(2).getStringArray();
  String[] heavy = a.getJSONArray(3).getStringArray();
  String[] general = a.getJSONArray(4).getStringArray();

  ArrayList<String[]> retos = new ArrayList();
  retos.add(low);
  retos.add(medium);
  retos.add(heavy);
  retos.add(general);

  JSONArray b = json.getJSONArray("verdades");
  ArrayList<String> verd = new ArrayList(Arrays.asList(b.getStringArray()));

  int cant = int(JOptionPane.showInputDialog("Cantidad de jugadores A"));
  int cant1 = int(JOptionPane.showInputDialog("Cantidad de jugadores B"));

  Persona[] personasA = new Persona[cant];
  Persona[] personasB = new Persona[cant1];

  for (int i = 0; i < cant; i++) {
    String nombre = JOptionPane.showInputDialog("Nombre de jugador " + i);
    personasA[i] = new Persona(nombre, low.length, medium.length, heavy.length);
  }

  for (int i = 0; i < cant1; i++) {
    String nombre = JOptionPane.showInputDialog("Nombre de jugador " + (cant + i));
    personasB[i] = new Persona(nombre, low.length, medium.length, heavy.length);
  }

  juego = new Juego(retos, verd, personasB, personasA);

  //for (int i =0; i < cant1+cant; i++) {
  //  println(i);
  //  printArray(juego.personas[i].personas);
  //}

  //for (int i = 0; i < 60; i++)
  //  println(juego.jugar(false));

  gui();
}


void draw() {
  background(0);
  text(juego.nivel, 50, 50);

  if (acc != null) {
    textSize(32);
    text(acc, width/2-210, height/2-100, 500, 1000);
  } else
    acc = juego.jugar(vd);
}

void gui() {
  cp5 = new ControlP5(this);
  //cp5.addTextfield("textInput_1").setPosition(20, 100).setSize(200, 40).setAutoClear(false);
  //cp5.addTextfield("textInput_2").setPosition(20, 170).setSize(200, 40).setAutoClear(false);
  cp5.addBang("reto")
    .setLabel("reto")
    .setPosition(width/2 - 100 - 40, 1000)
    .setSize(80, 20);


  cp5.addBang("verdad")
    .setLabel("verdad")
    .setPosition(width/2 + 100, 1000)
    .setSize(80, 20);

  cp5.addBang("nivelM")
    .setLabel("aumentar nivel")
    .setPosition(width - 100, 1000)
    .setSize(40, 40);

  cp5.addBang("nivelm")
    .setLabel("disminuir nivel")
    .setPosition(0 + 60, 1000)
    .setSize(40, 40);
}

void reto() {
  acc = juego.jugar(false);
  vd = false;
}

void verdad() {
  acc = juego.jugar(true);
  vd = true;
}

void nivelM() {
  if (juego.nivel + 1 <= 2) 
    juego.nivel++;
}

void nivelm() {
  if (juego.nivel - 1 >= 0) 
    juego.nivel--;
}