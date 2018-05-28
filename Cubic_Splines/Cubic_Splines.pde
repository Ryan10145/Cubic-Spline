ArrayList<ControlPoint> points;
ArrayList<CubicCurve> curves;

void setup()
{
    size(1000, 600);
    frameRate(60);

    points = new ArrayList<ControlPoint>();
    curves = new ArrayList<CubicCurve>();
}

void draw()
{
    for(ControlPoint point : points)
    {
        point.draw(5);
    }
    for(CubicCurve curve : curves)
    {
        curve.draw(0);
    }
}

void mousePressed()
{
    points.add(new ControlPoint(mouseX, height - mouseY));
    if(points.size() % 4 == 0 && points.size() != 0)
    {
        //Create a new cubic curve (generate parameters with a matrix)
        Matrix A = new Matrix(4, 4);
        Matrix b = new Matrix(4, 1);

        double minX = Integer.MAX_VALUE, maxX = Integer.MIN_VALUE;

        for(int i = points.size() - 4; i < points.size(); i++)
        {
            ControlPoint point = points.get(i);
            int row = i - (points.size() - 4);
            
            double x = point.x;
            double y = point.y;

            if(x < minX) minX = x;
            if(x > maxX) maxX = x;

            for(int col = 0; col < 4; col++)
            {
                A.setNumber(Math.pow(x, 3 - col), row, col);
            }
            b.setNumber(y, row, 0);
        }

        MatrixSystem system = new MatrixSystem(A, b);
        double[] parameters = system.solve();

        curves.add(new CubicCurve(parameters, minX, maxX));
    }
}