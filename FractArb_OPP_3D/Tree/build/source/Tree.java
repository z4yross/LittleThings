import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import peasy.org.apache.commons.math.*; 
import peasy.org.apache.commons.math.geometry.*; 
import shapes3d.*; 
import shapes3d.animation.*; 
import shapes3d.utils.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Tree extends PApplet {





private ArrayList<Branch> tree = new ArrayList();

private PeasyCam cam;

public void setup(){
  
  cam = new PeasyCam(this, 3000);
  PVector a = new PVector(width/2, height);
  PVector b = new PVector(width/2, height-700);
  Branch root = new Branch(a,b,this,1);

  tree.add(root);
}
public void draw(){
  lights();
  background(51);

  for(Branch b: tree){
    b.show();
  }
}

public void keyPressed(){

  for(int  i = tree.size() - 1; i >= 0; i--){
    if(!tree.get(i).getFinished()){
      tree.add(tree.get(i).branchA());
      tree.add(tree.get(i).branchB());
      //tree.add(tree.get(i).branchC());
      //tree.add(tree.get(i).branchD());
    }
    tree.get(i).setFinished(true);
  }

}




public class Branch{

  private PVector begin;
  private PVector end;
  private Boolean finished;
  private PApplet parent;
  private int level;

  public Branch(PVector begin, PVector end, PApplet p, int i){
    parent = p;
    this.begin = begin;
    this.end = end;
    finished = false;
    level = i;
  }

  public void setFinished(Boolean finished){
    this.finished = finished;
  }

  public Boolean getFinished(){
    return finished;
  }

  public void show(){
    noStroke();
    fill(255);
    Tube t = new Tube(parent,5,5);
    t.setSize(10,10,10,10);
    t.setWorldPos(begin, end);
    t.draw();
    //stroke(255);
    //line(begin.x, begin.y, 0, end.x, end.y,0);
  }

  public Branch branchA(){
    PVector dir = PVector.sub(end,begin);
    dir.rotate(PI/random(3.0f,7.0f));
    dir.mult(random(0.67f, 0.73f));
    PVector newEnd = PVector.add(end, dir);
    Branch b = new Branch(end, newEnd, parent, level++);
    return b;
  }

  public Branch branchB(){
    PVector dir = PVector.sub(end,begin);
    dir.rotate(-PI/random(3.0f,7.0f));
    dir.mult(random(0.67f, 0.73f));
    PVector newEnd = PVector.add(end, dir);
    Branch b = new Branch(end, newEnd, parent, level++);
    return b;
  }

  /*public Branch branchC(){
    PVector dir = PVector.sub(end,begin);
    dir.rotate(PI/3);
    dir.mult(0.67);
    PVector newEnd = PVector.add(end, dir);
    Branch b = new Branch(end, newEnd, parent);
    return b;
  }

  public Branch branchD(){
    PVector dir = PVector.sub(end,begin);
    dir.rotate(-PI/6);
    dir.mult(0.67);
    PVector newEnd = PVector.add(end, dir);
    Branch b = new Branch(end, newEnd, parent);
    return b;
  }*/

}
  public void settings() {  size(900,900, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Tree" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
