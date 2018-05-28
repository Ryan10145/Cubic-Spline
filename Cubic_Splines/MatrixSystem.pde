//Class for solving systems of equations using matrices

public class MatrixSystem
{
    Matrix A;
    Matrix L;
    Matrix U;
    Matrix P;

    Matrix C;
    Matrix X;
    Matrix Z;

    boolean calculatedLUP;
    boolean calculatedZ;
    boolean calculatedX;

    public MatrixSystem(Matrix A, Matrix C)
    {
        if(A.rows != C.rows) 
            throw new IllegalArgumentException("System created with matrices of size " + A.rows + " : " + A.cols + 
                " and " + C.rows + " : " + C.cols);

        this.A = A;
        this.C = C;

        L = null;
        U = null;
        P = null;

        X = new Matrix(A.rows, 1);
        Z = new Matrix(A.rows, 1);

        calculatedLUP = false;
        calculatedZ = false;
        calculatedX = false;
    }

    public MatrixSystem(double[][] A, double[] C)
    {
        this(new Matrix(A), new Matrix(C));
    }

    public MatrixSystem(double[][] A, double[][] C)
    {
        this(new Matrix(A), new Matrix(C));
    }

    void calculateLUP()
    {
        double[][][] LUP = decomposeLUP(A);
        L = new Matrix(LUP[0]);
        U = new Matrix(LUP[1]);
        P = new Matrix(LUP[2]);

        calculatedLUP = true;
    }

    void calculateZ()
    {
        Matrix PC = mult(P, C);
        for(int row = 0; row < Z.rows; row++)
        {
            double value = PC.getNumber(row, 0);
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
            for(int col = X.rows - 1; col > row; col--)
            {
                value -= U.getNumber(row, col) * X.getNumber(col, 0);
            }

            value /= U.getNumber(row, row);
            X.setNumber(value, row, 0);
        }

        calculatedX = true;
    }

    void calculateSolutions()
    {
        if(!calculatedLUP) calculateLUP();
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

    double[] getXArray()
    {
        double[] solutions = new double[X.rows];
        for(int i = 0; i < X.numbers.length; i++)
        {
            solutions[i] = X.numbers[i][0];
        }

        return solutions;
    }
}