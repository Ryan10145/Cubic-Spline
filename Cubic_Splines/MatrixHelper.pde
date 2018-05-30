//Contains the static helper methods for Matrices

void printMatrix(double[][] numbers, int decimalPlaces)
{
    for(int i = 0; i < numbers.length; i++)
    {
        for(int j = 0; j < numbers[i].length; j++)
        {
            print(String.format("% ." + decimalPlaces + "f ", numbers[i][j]));
        }
        println();
    }
    println();
}

public Matrix identity(int size)
{
    double[][] nums = new double[size][size];

    for(int row = 0; row < size; row++)
    {
        for(int col = 0; col < size; col++)
        {
            nums[row][col] = ((row == col) ? 1 : 0);
        }
    }

    return new Matrix(nums);
}

public Matrix zero(int rows, int cols)
{
    double[][] zeros = new double[rows][cols];

    for(int row = 0; row < rows; row++)
    {
        for(int col = 0; col < cols; col++)
        {
            zeros[row][col] = 0;
        }
    }

    return new Matrix(zeros);
}

public double dot(double[] arr1, double[] arr2)
{
    double sum = 0;
    if(arr1.length != arr2.length) 
        throw new IllegalArgumentException("Dot Product of " + arr1.length + " and " + arr2.length);

    for(int i = 0; i < arr1.length; i++)
    {
        sum += arr1[i] * arr2[i];
    }

    return sum;
}

public Matrix add(Matrix matrix1, Matrix matrix2)
{
    if(matrix1.rows != matrix2.rows || matrix1.cols != matrix2.cols) 
        throw new IllegalArgumentException("Added Matrices " + matrix1.rows + " : " + matrix1.cols + 
                                            " and " + matrix2.rows + " : " + matrix2.cols);

    Matrix matrix = new Matrix(matrix1.rows, matrix1.cols);

    for(int row = 0; row < matrix.rows; row++)
    {
        for(int col = 0; col < matrix.cols; col++)
        {
            matrix.numbers[row][col] = matrix1.numbers[row][col] + matrix2.numbers[row][col];
        }
    }

    return matrix;
}

public Matrix sub(Matrix matrix1, Matrix matrix2)
{
    if(matrix1.rows != matrix2.rows || matrix1.cols != matrix2.cols) 
        throw new IllegalArgumentException("Subtracted Matrices " + matrix1.rows + " : " + matrix1.cols + 
                                            " and " + matrix2.rows + " : " + matrix2.cols);

    Matrix matrix = new Matrix(matrix1.rows, matrix1.cols);

    for(int row = 0; row < matrix.rows; row++)
    {
        for(int col = 0; col < matrix.cols; col++)
        {
            matrix.numbers[row][col] = matrix1.numbers[row][col] - matrix2.numbers[row][col];
        }
    }

    return matrix;
}

public Matrix mult(Matrix matrix1, Matrix matrix2)
{
    if(matrix1.cols != matrix2.rows) 
        throw new IllegalArgumentException("Multiplied Matrices " + matrix1.rows + " : " + matrix1.cols + 
                                            " and " + matrix2.rows + " : " + matrix2.cols);

    double[][] newNumbers = new double[matrix1.rows][matrix2.cols];

    for(int row = 0; row < matrix1.rows; row++)
    {
        for(int col = 0; col < matrix2.cols; col++)
        {
            newNumbers[row][col] = dot(matrix1.getRow(row), matrix2.getCol(col));
        }
    }

    return new Matrix(newNumbers);
}

public double[][] mult(double[][] matrix1, double[][] matrix2)
{
    Matrix matrix1M = new Matrix(matrix1);
    Matrix matrix2M = new Matrix(matrix2);

    return mult(matrix1M, matrix2M).numbers;
}

public Matrix transpose(Matrix matrix)
{
    double[][] newNumbers = new double[matrix.cols][matrix.rows];

    for(int row = 0; row < matrix.rows; row++)
    {
        for(int col = 0; col < matrix.cols; col++)
        {
            newNumbers[col][row] = matrix.numbers[row][col];
        }
    }

    return new Matrix(newNumbers);
}

public double[][] transpose(double[][] matrix)
{
    double[][] newNumbers = new double[matrix[0].length][matrix.length];

    for(int row = 0; row < matrix.length; row++)
    {
        for(int col = 0; col < matrix[0].length; col++)
        {
            newNumbers[col][row] = matrix[row][col];
        }
    }

    return newNumbers;
}

public void swapRows(double[][] numbers, int row1, int row2)
{
    double[] temp = numbers[row1];
    numbers[row1] = numbers[row2];
    numbers[row2] = temp;
}

public void swapCols(double[][] numbers, int col1, int col2)
{
    for(int row = 0; row < numbers.length; row++)
    {
        double temp = numbers[row][col1];
        numbers[row][col1] = numbers[row][col2];
        numbers[row][col2] = temp;
    }
}

//{0 - lower, 1 - upper, 2 - permutation, 3 - 1x1 array with row exchanges}
//PA = LU
public double[][][] decomposeLUP(Matrix A)
{
    int rows = A.rows;
    int cols = A.cols;
    double[][] numbers = new double[rows][cols];

    if(rows != cols) 
        throw new IllegalArgumentException("LUP Decomposition of " + rows + " : " + cols);

    double[][] lower = new double[rows][cols];
    double[][] upper = new double[rows][cols];

    double[][][] pivotData = pivotize(A.numbers);
    double[][] permutation = pivotData[0];
    int rowExchanges = (int) pivotData[1][0][0];

    double[][] A2 = mult(permutation, A.numbers);
    
    for(int j = 0; j < rows; j++)
    {
        lower[j][j] = 1;
        for(int i = 0; i < j + 1; i++)
        {
            double s1 = 0;
            for(int k = 0; k < i; k++)
            {
                s1 += upper[k][j] * lower[i][k];
            }
            upper[i][j] = A2[i][j] - s1;
        }
        for(int i = j; i < rows; i++)
        {
            double s2 = 0;
            for(int k = 0; k < j; k++)
            {
                s2 += upper[k][j] * lower[i][k];
            }
            lower[i][j] = (A2[i][j] - s2) / upper[j][j];
        }
    }

    return new double[][][] {lower, upper, permutation, new double[][] {{rowExchanges}}};
}

//1st - pivoted array, 2nd - 1x1 array with amount of row exchanges
public double[][][] pivotize(double[][] matrix)
{
    int rows = matrix.length;
    double[][] id = identity(rows).numbers;
    int exchanges = 0;

    for(int i = 0; i < rows; i++)
    {
        double max = matrix[i][i];
        int row = i;
        for(int j = i; j < rows; j++)
        {
            if(matrix[j][i] > max)
            {
                max = matrix[j][i];
                row = j;
            }
        }

        if(i != row)
        {
            swapRows(id, i, row);
            exchanges++;
        }
    }

    return new double[][][] {id, new double[][] {{exchanges}}};
}

public Matrix inverse(Matrix matrix)
{
    Matrix ide = identity(matrix.rows);
    Matrix inv = new Matrix(matrix.rows, matrix.cols);

    MatrixSystem system = new MatrixSystem(matrix, ide.getColMatrix(0));
    system.calculateLUP();

    for(int col = 0; col < matrix.cols; col++)
    {
        if(col != 0)
        {
            system.C = ide.getColMatrix(col);
        }

        system.calculateZ();
        system.calculateX();

        double[] solutions = system.getXArray();
        for(int i = 0; i < solutions.length; i++)
        {
            inv.setNumber(solutions[i], i, col);
        }
    }

    return inv;
}