//Class for drawing a cubic equation in a certain range

public class CubicCurve
{
    double a;
    double b;
    double c;
    double d;

    double startX;
    double endX;

    final double STEP = 0.25;

    public CubicCurve(double a, double b, double c, double d, double startX, double endX)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;

        this.startX = startX;
        this.endX = endX;
    }

    void draw(color strokeColor)
    {
        stroke(strokeColor);
        strokeWeight(1);
        noFill();

        beginShape();
        for(double x = startX; x <= endX; x += STEP)
        {
            vertex((float) x, (float) -(a * x * x * x + b * x * x + c * x + d));
        }
        endShape();
    }
}