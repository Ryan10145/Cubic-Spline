void generatePath()
{
    Collections.sort(points);
    
    if(points.size() <= 2)
    {
        curves.clear();
    }
    else
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
                // println("Point 1", i, j);
                double x = Math.pow(point.x, j);
                matrix.setNumber(x, currentRow, i * 4 + (3 - j));
                answers.setNumber(point.y, currentRow, 0);
            }
            currentRow++;
            //Point 2
            for(int j = 0; j < 4; j++)
            {
                // println("Point 2", i, j);
                double x = Math.pow(nextPoint.x, j);
                matrix.setNumber(x, currentRow, i * 4 + (3 - j));
            }
            answers.setNumber(nextPoint.y, currentRow, 0);
            currentRow++;

            //First Slope if First Segment
            if(i == 0)
            {
                double slope = (nextPoint.y - point.y) / (nextPoint.x - point.x);
                for(int j = 0; j < 3; j++)
                {
                    // println("First Slope", i, j);
                    double x = Math.pow(point.x, j);
                    matrix.setNumber(x * (j + 1), currentRow, i * 4 + (2 - j));
                }
                answers.setNumber(slope, currentRow, 0);
                currentRow++;
            }
            //Second Slope if First/Middle Segment (Join)
            if(i != points.size() - 2)
            {
                // println("Second Slope", i);
                for(int j = 0; j < 3; j++)
                {
                    // println("First Area", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(x * (j + 1), currentRow, i * 4 + (2 - j));
                }
                for(int j = 0; j < 3; j++)
                {
                    // println("Second Area", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(-x * (j + 1), currentRow, 4 + i * 4 + (2 - j));
                }
                answers.setNumber(0, currentRow, 0);
                currentRow++;
            }
            //Curvature if First/Middle Segment
            if(i != points.size() - 2)
            {
                // println("Curvature", i);
                for(int j = 0; j < 2; j++)
                {
                    double x = Math.pow(nextPoint.x, j);
                    if(j == 0) x *= 2;
                    else if(j == 1) x *= 6;
                    matrix.setNumber(x, currentRow, i * 4 + (1 - j));
                }
                for(int j = 0; j < 2; j++)
                {
                    double x = Math.pow(nextPoint.x, j);
                    if(j == 0) x *= 2;
                    else if(j == 1) x *= 6;
                    matrix.setNumber(-x, currentRow, 4 + i * 4 + (1 - j));
                }
                answers.setNumber(0, currentRow, 0);
                currentRow++;
            }
            //Slope if End Segment
            if(i == points.size() - 2)
            {
                double slope = (nextPoint.y - point.y) / (nextPoint.x - point.x);
                for(int j = 0; j < 3; j++)
                {
                    // println("End Slope", i, j);
                    double x = Math.pow(nextPoint.x, j);
                    matrix.setNumber(x * (j + 1), currentRow, i * 4 + (2 - j));
                }
                answers.setNumber(slope, currentRow, 0);
                currentRow++;
            }

            println(point.x, point.y);
            if(i == points.size() - 2) println(nextPoint.x, nextPoint.y);
        }

        MatrixSystem system = new MatrixSystem(matrix, answers);
        printMatrix(matrix.numbers, 0);
        printMatrix(answers.numbers, 0);
        double[] parameters = system.solve();

        curves.clear();
        for(int i = 0; i < points.size() - 1; i++)
        {
            curves.add(new CubicCurve(subarray(parameters, i * 4, (i * 4) + 4), 
                points.get(i).x, points.get(i + 1).x));
        }
    }
}