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
    
    if(points.size() > 2)
    {
        int matrixSize = (points.size() - 1) * 4;
        Matrix matrix = new Matrix(matrixSize, matrixSize);
        Matrix answers = new Matrix(matrixSize, 1);
        int currentRow = 0;

        for(int i = 0; i < points.size() - 1; i++)
        {
            ControlPoint point = points.get(i);
            ControlPoint nextPoint = points.get(i + 1);

            //Point 1
            for(int j = 0; j < 4; j++)
            {
                println("Point 1", i, j);
                double x = Math.pow(point.x, j);
                matrix.setNumber(x, currentRow, i * 4 + (3 - j));
                answers.setNumber(point.y, currentRow, 0);
            }
            currentRow++;
            //Point 2
            for(int j = 0; j < 4; j++)
            {
                println("Point 2", i, j);
                double x = Math.pow(nextPoint.x, j);
                matrix.setNumber(x, currentRow, i * 4 + (3 - j));
            }
            answers.setNumber(nextPoint.y, currentRow, 0);
            currentRow++;

            //First Slope if First Segment
            if(i == 0)
            {
                double slope = 2;
                for(int j = 0; j < 3; j++)
                {
                    println("First Slope", i, j);
                    double x = Math.pow(point.x, j);
                    matrix.setNumber(x, currentRow, i * 4 + (2 - j));
                }
                answers.setNumber(slope, currentRow, 0);
                currentRow++;
            }
            //Second Slope if First/Middle Segment (Join)
            if(i != points.size() - 2)
            {
                println("Second Slope", i);
                for(int j = 0; j < 3; j++)
                {
                    println("First Area", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(x, currentRow, i * 4 + (2 - j));
                }
                for(int j = 0; j < 3; j++)
                {
                    println("Second Area", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(-x, currentRow, 4 + i * 4 + (2 - j));
                }
                answers.setNumber(0, currentRow, 0);
                currentRow++;
            }
            //Curvature if First/Middle Segment
            if(i != points.size() - 2)
            {
                println("Curvature", i);
                for(int j = 0; j < 2; j++)
                {
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(x, currentRow, i * 4 + (1 - j));
                }
                for(int j = 0; j < 2; j++)
                {
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(-x, currentRow, 4 + i * 4 + (1 - j));
                }
                answers.setNumber(0, currentRow, 0);
                currentRow++;
            }
            //Slope if End Segment
            if(i == points.size() - 2)
            {
                double slope = 2;
                for(int j = 0; j < 3; j++)
                {
                    println("End Slope", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(x, currentRow, i * 4 + (2 - j));
                }
                answers.setNumber(slope, currentRow, 0);
                currentRow++;
            }
        }

        MatrixSystem system = new MatrixSystem(matrix, answers);
        double[] parameters = system.solve();

        curves.clear();
        for(int i = 0; i < points.size() - 1; i++)
        {
            curves.add(new CubicCurve(subarray(parameters, i * 4, (i * 4) + 4), points.get(i).x, points.get(i + 1).x));
        }
    }

    // if(points.size() % 4 == 0 && points.size() != 0)
    // {
    //     double[][] matrixTransform = null;

    //     //Check for any duplicate x values
    //     //If there are any, change the x slightly
    //     ControlPoint[] tempPoints = new ControlPoint[4];
    //     for(int i = points.size() - 4; i < points.size(); i++)
    //     {
    //         tempPoints[i - (points.size() - 4)] = points.get(i).clone();
    //         for(int j = i + 1; j < points.size(); j++)
    //         {
    //             if(points.get(j).x == points.get(i).x)
    //             {
    //                 points.get(i).x += ((i - (points.size() - 4)) / 10.0);
    //                 break;
    //             }
    //         }
    //     }

    //     //Create a new cubic curve (generate parameters with a matrix)
    //     Matrix A = new Matrix(4, 4);
    //     Matrix b = new Matrix(4, 1);

    //     double minX = Integer.MAX_VALUE, maxX = Integer.MIN_VALUE;

    //     for(int row = 0; row < tempPoints.length; row++)
    //     {
    //         ControlPoint point = tempPoints[row];
            
    //         double x = point.x;
    //         double y = point.y;

    //         if(x < minX) minX = x;
    //         if(x > maxX) maxX = x;

    //         for(int col = 0; col < 4; col++)
    //         {
    //             A.setNumber(Math.pow(x, 3 - col), row, col);
    //         }
    //         b.setNumber(y, row, 0);
    //     }

    //     MatrixSystem system = new MatrixSystem(A, b);
    //     double[] parameters = system.solve();

    //     curves.add(new CubicCurve(parameters, minX, maxX));
    // }
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

void keyPressed()
{
    points.clear();
    curves.clear();

    background(254);
}