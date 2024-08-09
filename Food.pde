public class Food {
  public PVector pos;

  public Food(int x, int y) {
    this.pos = new PVector(x, y);
  }

  void show(int scl) {
    pushMatrix();
    fill(color(200, 30, 30));
    noStroke();
    rect(this.pos.x * scl, this.pos.y * scl, scl, scl);
    popMatrix();
  }
}
