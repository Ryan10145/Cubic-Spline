import java.util.Collections;

ArrayList<ControlPoint> points;
ArrayList<CubicCurve> curves;

ControlPoint hoverPoint;

boolean shift;
int tintAlpha;

final int MAX_POINTS = 20;

void setup()
{
    size(1000, 600);
    frameRate(60);

    points = new ArrayList<ControlPoint>();
    curves = new ArrayList<CubicCurve>();

    shift = false;
    tintAlpha = 0;
}

void draw()
{
    background(255);

    hoverPoint = null;
    for(ControlPoint point : points)
    {
        int thickness = 8;
        color drawColor = color(0);
        if(point.hover())
        {
            thickness *= 2;
            hoverPoint = point;
            drawColor = color(50, 200);
            if(shift) drawColor = color(255, 0, 0, 200);
        }
        point.draw(thickness, drawColor);
    }
    for(CubicCurve curve : curves)
    {
        curve.draw(0);
    }

    //Draw tint for the too many points warning
    fill(255, 0, 0, tintAlpha);
    noStroke();
    rectMode(CENTER);
    rect(width / 2, height / 2, width, height);
    if(tintAlpha > 0) tintAlpha -= 8;
}

void mousePressed()
{
    if(hoverPoint == null)
    {
        if(points.size() < MAX_POINTS)
        {
            points.add(new ControlPoint(mouseX, height - mouseY));
            generatePath();
        }
        else tintAlpha = 128;
    }
    else if(shift)
    {
        points.remove(hoverPoint);
        generatePath();
    }
}

void mouseDragged()
{
    if(hoverPoint != null)
    {
        hoverPoint.x = mouseX;
        hoverPoint.y = height - mouseY;
    }
}

void mouseReleased()
{
    generatePath();
}

void keyPressed()
{
    if(key == 'r' || key == 'R')
    {
        points.clear();
        curves.clear();

        background(254);
    }

    if(keyCode == SHIFT) shift = true;
}

void keyReleased()
{
    if(keyCode == SHIFT) shift = false;
}

//Inclusive start, exclusive end
double[] subarray(double[] array, int start, int end)
{
    double[] returnArray = new double[end - start];
    for(int i = 0; i < end - start; i++)
    {
        returnArray[i] = array[start + i];
    }

    return returnArray;
}