//Class for storing a point that manipulates a cubic curve

public class ControlPoint implements Comparable
{
    double x, y;

    public ControlPoint(double x, double y)
    {
        this.x = x;
        this.y = y;
    }

    void draw(int thickness, color drawColor)
    {
        stroke(drawColor);
        strokeWeight(thickness);
        point((float) x, height - (float) y);
    }

    ControlPoint clone()
    {
        return new ControlPoint(x, y);
    }

    void mult(double[][] matrix)
    {
        double tempX = dot(new double[] {x, y}, matrix[0]);
        double tempY = dot(new double[] {x, y}, matrix[1]);

        this.x = tempX;
        this.y = tempY;
    }

    @Override
    public int compareTo(Object other)
    {
        return (int) (this.x - ((ControlPoint) other).x);
    }

    boolean hover()
    {
        return ((Math.pow(this.x - mouseX, 2) + Math.pow((height - this.y) - mouseY, 2)) < 25);
    }
}