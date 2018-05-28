//Class for storing a point that manipulates a cubic curve

public class ControlPoint
{
    double x, y;

    public ControlPoint(double x, double y)
    {
        this.x = x;
        this.y = y;
    }

    void draw(int thickness)
    {
        stroke(0);
        strokeWeight(thickness);
        point((float) x, height - (float) y);
    }
}