import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;

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
    dir.rotate(PI/random(3.0,7.0));
    dir.mult(random(0.67, 0.73));
    PVector newEnd = PVector.add(end, dir);
    Branch b = new Branch(end, newEnd, parent, level++);
    return b;
  }

  public Branch branchB(){
    PVector dir = PVector.sub(end,begin);
    dir.rotate(-PI/random(3.0,7.0));
    dir.mult(random(0.67, 0.73));
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
