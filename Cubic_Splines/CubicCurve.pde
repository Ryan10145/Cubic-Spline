//Class for drawing a cubic equation in a certain range

public class CubicCurve
{
    double a;
    double b;
    double c;
    double d;

    double startX;
    double endX;

    final double STEP = 1;

    public CubicCurve(double a, double b, double c, double d, double startX, double endX)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;

        this.startX = startX;
        this.endX = endX;
    }

    public CubicCurve(double[] parameters, double startX, double endX)
    {
        this(parameters[0], parameters[1], parameters[2], parameters[3], startX, endX);
    }

    void draw(color strokeColor)
    {   
        stroke(strokeColor);
        strokeWeight(3);
        noFill();

        beginShape();
        for(double x = startX; x <= endX; x += STEP)
        {
            double[] coords = new double[] {x, a * x * x * x + b * x * x + c * x + d};
            vertex((float) coords[0], (float) (height - coords[1]));
        }
        endShape();
    }
}