//Class for representing matrices and various matrix operations

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

    public double determinant()
    {
        double[][][] numbers = decomposeLUP(this);
        double[][] lower = numbers[0];
        double[][] upper = numbers[1];

        double rowExchanges = numbers[3][0][0];

        double determinantL = 1;
        double determinantU = 1;
        double determinantP = Math.pow(-1, rowExchanges);
        for(int i = 0; i < rows; i++)
        {
            determinantL *= lower[i][i];
            determinantU *= upper[i][i];
        }

        return determinantL * determinantU * determinantP;
    }
}