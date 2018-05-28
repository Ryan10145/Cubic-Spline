CubicCurve curve;

void setup()
{
    size(1000, 600);

    curve = new CubicCurve(0, 1, 0, 0, -width / 2, width / 2);
}

void draw()
{
    pushMatrix();
    translate(width / 2, height / 2);
    curve.draw(color(0));
    popMatrix();
}