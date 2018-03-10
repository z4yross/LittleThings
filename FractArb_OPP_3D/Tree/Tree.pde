import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

private ArrayList<Branch> tree = new ArrayList();

private PeasyCam cam;

public void setup(){
  size(900,900, P3D);
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
