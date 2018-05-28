CubicCurve curve;

void setup()
{
    size(1000, 600);
    frameRate(60);

    curve = new CubicCurve(0, 0.01, 0, 0, -width / 2, width / 2);
}

void draw()
{
    curve.a = (float(mouseX) / width) * (float(mouseX) / width);
    println(curve.b);

    background(254);
    pushMatrix();
    translate(width / 2, height / 2);
    curve.draw(color(0));
    popMatrix();
}