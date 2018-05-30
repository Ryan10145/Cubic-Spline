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
        double[][] matrixTransform = null;

        //Check for any duplicate x values
        //While there are duplicate x values, rotate all of the points, generate the cubic curve, and then unrotate
        ControlPoint[] tempPoints = new ControlPoint[4];
        boolean duplicate = false;
        for(int i = points.size() - 4; i < points.size(); i++)
        {
            tempPoints[i - (points.size() - 4)] = points.get(i).clone();
            for(int j = i + 1; j < points.size() && !duplicate; j++)
            {
                if(points.get(j).x == points.get(i).x) duplicate = true;
            }
        }

        double angle = PI / 6.0;

        while(duplicate)
        {
            //Reset the points
            for(int i = points.size() - 4; i < points.size(); i++)
            {
                tempPoints[i - (points.size() - 4)] = points.get(i).clone();
            }

            //Apply a matrix transform
            matrixTransform = rotation(angle);
            for(int i = 0; i < tempPoints.length; i++)
            {
                tempPoints[i].mult(matrixTransform);
            }

            //Recheck for duplicates
            duplicate = false;
            for(int i = 0; i < tempPoints.length; i++)
            {
                for(int j = i + 1; j < tempPoints.length && !duplicate; j++)
                {
                    if(tempPoints[i].x == tempPoints[j].x) duplicate = true;
                }
            }

            angle *= 2.0;
        }

        //Create a new cubic curve (generate parameters with a matrix)
        Matrix A = new Matrix(4, 4);
        Matrix b = new Matrix(4, 1);

        double minX = Integer.MAX_VALUE, maxX = Integer.MIN_VALUE;

        for(int row = 0; row < tempPoints.length; row++)
        {
            ControlPoint point = tempPoints[row];
            
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

        if(matrixTransform != null) matrixTransform = transpose(matrixTransform);
        curves.add(new CubicCurve(parameters, minX, maxX, matrixTransform));
    }
}