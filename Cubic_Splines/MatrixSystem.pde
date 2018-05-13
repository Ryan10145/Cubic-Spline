public class MatrixSystem
{
    Matrix A;
    Matrix L;
    Matrix U;

    Matrix C;
    Matrix X;
    Matrix Z;

    boolean calculatedLU;
    boolean calculatedZ;
    boolean calculatedX;

    public MatrixSystem(Matrix A, Matrix C)
    {
        this.A = A;
        this.C = C;

        L = null;
        U = null;

        X = new Matrix(A.rows, 1);
        Z = new Matrix(A.rows, 1);

        calculatedLU = false;
        calculatedZ = false;
        calculatedX = false;
    }

    void calculateLU()
    {
        double[][][] LU = A.decomposeLU();
        L = new Matrix(LU[0]);
        U = new Matrix(LU[1]);

        calculatedLU = true;
    }

    void calculateZ()
    {
        for(int row = 0; row < Z.rows; row++)
        {
            double value = C.getNumber(row, 0);
            for(int col = 0; col < row; col++)
            {
                value -= (L.getNumber(row, col) * Z.getNumber(col, 0));
            }

            Z.setNumber(value, row, 0);
        }

        calculatedZ = true;
    }

    void calculateX()
    {
        for(int row = X.rows - 1; row >= 0; row--)
        {
            double value = Z.getNumber(row, 0);
            for(int col = 1; col <= row; col++)
            {
                col = U.cols - col;
                value -= U.getNumber(row, col) * X.getNumber(col, 0);
            }

            value /= U.getNumber(row, row);
            X.setNumber(value, row, 0);
        }

        calculatedX = true;
    }

    void calculateSolutions()
    {
        if(!calculatedLU) calculateLU();
        if(!calculatedZ) calculateZ();
        if(!calculatedX) calculateX();
    }

    Matrix solveMatrix()
    {
        calculateSolutions();
        return X;
    }
    
    double[] solve()
    {
        calculateSolutions();
        double[] solutions = new double[X.rows];
        for(int i = 0; i < X.numbers.length; i++)
        {
            solutions[i] = X.numbers[i][0];
        }

        return solutions;
    }
}