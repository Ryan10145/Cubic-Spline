//Class for drawing a cubic equation in a certain range

public class CubicCurve
{
    double a;
    double b;
    double c;
    double d;

    double startX;
    double endX;

    double[][] transform;

    final double STEP = 1;

    public CubicCurve(double a, double b, double c, double d, double startX, double endX, double[][] transform)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;

        this.startX = startX;
        this.endX = endX;

        this.transform = transform;
    }

    public CubicCurve(double[] parameters, double startX, double endX)
    {
        this(parameters[0], parameters[1], parameters[2], parameters[3], startX, endX, null);
    }

    public CubicCurve(double[] parameters, double startX, double endX, double[][] transform)
    {
        this(parameters[0], parameters[1], parameters[2], parameters[3], startX, endX, transform);
    }

    void draw(color strokeColor)
    {   
        stroke(strokeColor);
        strokeWeight(1);
        noFill();

        beginShape();
        for(double x = startX; x <= endX; x += STEP)
        {
            double[] coords = new double[] {x, a * x * x * x + b * x * x + c * x + d};

            if(transform != null)
            {
                double newX = dot(coords, transform[0]);
                double newY = dot(coords, transform[1]);

                coords[0] = newX;
                coords[1] = newY;
            }
            vertex((float) coords[0], (float) (height - coords[1]));
        }
        endShape();
    }
}