class Matrix
{
    int rows;
    int cols;

    double[][] numbers;

    public Matrix(int rows, int cols)
    {
        this.rows = rows;
        this.cols = cols;

        numbers = new double[rows][cols];
    }

    public Matrix(double[][] numbers)
    {
        this.numbers = numbers;

        this.rows = numbers.length;
        this.cols = numbers[0].length;
    }

    public Matrix(double[] numbers1D)
    {
        this.numbers = new double[numbers1D.length][1];
        for(int i = 0; i < numbers1D.length; i++)
        {
            this.numbers[i][0] = numbers1D[i];
        }

        this.rows = numbers1D.length;
        this.cols = 1;
    }

    public void setNumbers(double[][] numbers)
    {
        this.numbers = numbers;

        this.rows = numbers.length;
        this.cols = numbers[0].length;
    }

    public void setNumber(double number, int row, int col)
    {
        if(row >= rows || col >= cols) 
            throw new IllegalArgumentException("Passed Coordinates " + row + " : " + col + 
                                                " into Matrix of size " + rows + " : " + cols);
        numbers[row][col] = number;
    }

    public double getNumber(int row, int col)
    {
        if(row >= rows || col >= cols) 
            throw new IllegalArgumentException("Passed Coordinates " + row + " : " + col + 
                                                " into Matrix of size " + rows + " : " + cols);
        return numbers[row][col];
    }

    public double[] getRow(int row)
    {
        return numbers[row];
    }

    public Matrix getRowMatrix(int row)
    {
        return new Matrix(new double[][] {numbers[row]});
    }

    public double[] getCol(int col)
    {
        double[] colNumbers = new double[rows];

        for(int i = 0; i < colNumbers.length; i++)
        {
            colNumbers[i] = numbers[i][col];
        }

        return colNumbers;
    }

    public Matrix getColMatrix(int col)
    {
        Matrix matrix = new Matrix(this.rows, 1);
        for(int i = 0; i < rows; i++)
        {
            matrix.setNumber(this.numbers[i][col], i, 0);
        }

        return matrix;
    }

    public void printMatrix(int decimalPlaces)
    {
        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                print(String.format("% ." + decimalPlaces + "f ", numbers[row][col]));
            }
            println();
        }

        println();
    }

    public void add(Matrix other)
    {
        if(rows != other.rows || cols != other.cols) 
            throw new IllegalArgumentException("Added Matrices " + rows + " : " + cols + 
                                                " and " + other.rows + " : " + other.cols);

        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                numbers[row][col] += other.numbers[row][col];
            }
        }
    }

    public void sub(Matrix other)
    {
        if(rows != other.rows || cols != other.cols) 
            throw new IllegalArgumentException("Subtracted Matrices " + rows + " : " + cols + 
                                                " and " + other.rows + " : " + other.cols);

        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                numbers[row][col] -= other.numbers[row][col];
            }
        }
    }

    public void mult(int number)
    {
        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                numbers[row][col] *= number;
            }
        }
    }

    public void div(int number)
    {
        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                numbers[row][col] /= number;
            }
        }
    }

    public void transpose()
    {
        double[][] newNumbers = new double[cols][rows];

        for(int row = 0; row < rows; row++)
        {
            for(int col = 0; col < cols; col++)
            {
                newNumbers[col][row] = numbers[row][col];
            }
        }

        numbers = newNumbers;
        int temp = cols;
        cols = rows;
        rows = temp;
    }

    // public double determinant()
    // {
    //     if(rows != cols) throw new IllegalArgumentException("Determinant of size " + rows + " : " + cols);
    //     return determinant(this);
    // }

    // private double determinant(Matrix matrix)
    // {
    //     if(matrix.rows == 2 && matrix.cols == 2) return matrix.numbers[0][0] * matrix.numbers[1][1] - 
    //         (matrix.numbers[0][1] * matrix.numbers[1][0]);

    //     double sum = 0;
    //     for(int i = 0; i < matrix.cols; i++)
    //     {
    //         double topNum = matrix.numbers[0][i];
    //         double[][] otherNums = new double[matrix.rows - 1][matrix.cols - 1];
    //         for(int row = 1; row < matrix.rows; row++)
    //         {
    //             for(int col = 0; col < matrix.cols; col++)
    //             {
    //                 if(col != i)
    //                 {
    //                     otherNums[row - 1][col > i ? col - 1 : col] = matrix.numbers[row][col];
    //                 }
    //             }
    //         }

    //         sum -= topNum * determinant(new Matrix(otherNums)) * (((i % 2) * 2) - 1);
    //     }

    //     println(matrix.rows, sum);
    //     return sum;
    // }

    public void swapRows(int row1, int row2)
    {
        double[] temp = numbers[row1];
        numbers[row1] = numbers[row2];
        numbers[row2] = temp;
    }

    public void swapCols(int col1, int col2)
    {
        for(int row = 0; row < rows; row++)
        {
            double temp = numbers[row][col1];
            numbers[row][col1] = numbers[row][col2];
            numbers[row][col2] = temp;
        }
    }

    // public double determinant()
    // {
    //     double[][][] numbers = decomposeLU();
    //     double[][] lower = numbers[0];
    //     double[][] upper = numbers[1];

    //     double determinantL = 1;
    //     double determinantU = 1;
    //     for(int i = 0; i < rows; i++)
    //     {
    //         determinantL *= lower[i][i];
    //         determinantU *= upper[i][i];
    //     }

    //     return determinantL * determinantU;
    // }
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

public double[][] transpose(double[][] numbers)
{
    double[][] newNumbers = new double[numbers[0].length][numbers.length];

    for(int row = 0; row < numbers.length; row++)
    {
        for(int col = 0; col < numbers[0].length; col++)
        {
            newNumbers[col][row] = numbers[row][col];
        }
    }

    return newNumbers;
}

//{0 - lower, 1 - upper, 2 - permutation}
//PA = LU
private double[][][] decomposeLUP(Matrix A)
{
    int rows = A.rows;
    int cols = A.cols;
    double[][] numbers = new double[rows][cols];

    if(rows != cols) 
        throw new IllegalArgumentException("LUP Decomposition of " + rows + " : " + cols);

    double[][] lower = new double[rows][cols];
    double[][] upper = new double[rows][cols];
    double[][] permutation = identity(rows).numbers;

    for(int row = 0; row < rows; row++)
    {
        for(int col = 0; col < cols; col++)
        {
            lower[row][col] = 0;
            upper[row][col] = 0;
            numbers[row][col] = A.numbers[row][col];
        }
    }

    for(int i = 0; i < rows; i++)
    {
        //Pivoting
        double Umax = 0;
        int row = 0;
        for(int k = i; k < rows; k++)
        {
            double Uii = numbers[k][i];
            for(int j = 0; j < i; j++)
            {
                Uii -= numbers[k][j] * numbers[j][k];
            }
            if(Math.abs(Uii) > Umax)
            {
                Umax = Math.abs(Uii);
                row = k;
            }
        }
        if(i != row)
        {
            swapRows(permutation, row, i);
            swapRows(numbers, row, i);
            swapRows(lower, row, i);
            swapRows(upper, row, i);
        }

        //Upper Triangular
        for(int k = i; k < rows; k++)
        {
            double sum = 0;
            for(int j = 0; j < i; j++)
            {
                sum += lower[i][j] * upper[j][k];
            }

            upper[i][k] = numbers[i][k] - sum;
        }

        //Lower Triangular
        for(int k = i; k < rows; k++)
        {
            if(i == k) lower[i][i] = 1;
            else
            {
                double sum = 0;
                for(int j = 0; j < i; j++)
                {
                    sum += lower[k][j] * upper[j][i];
                }
                lower[k][i] = (numbers[k][i] - sum) / upper[i][i];
            }
        }
    }

    // for(int i = 0; i < permutation.length / 2; i++)
    // {
    //     swapRows(permutation, i, permutation.length - 1 - i);
    // }
    // permutation = transpose(permutation);

    return new double[][][] {lower, upper, permutation};
}

// public Matrix inverse(Matrix matrix)
// {
//     Matrix ide = identity(matrix.rows);
//     Matrix inv = new Matrix(matrix.rows, matrix.cols);

//     MatrixSystem system = new MatrixSystem(matrix, ide.getColMatrix(0));
//     system.calculateLU();

//     for(int col = 0; col < matrix.cols; col++)
//     {
//         if(col != 0)
//         {
//             system.C = ide.getColMatrix(col);
//         }

//         system.calculateZ();
//         system.calculateX();

//         double[] solutions = system.getXArray();
//         for(int i = 0; i < solutions.length; i++)
//         {
//             inv.setNumber(solutions[i], i, col);
//         }
//     }

//     return inv;
// }