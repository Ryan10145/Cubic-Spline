CubicCurve curve;

void setup()
{
    // size(1000, 600);

    // Matrix matrix1 = new Matrix(new double[][] {{10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}});
    Matrix A = new Matrix(new double[][] {{1, 2, 1, 6}, {4, 3, -1, 24}, {7, 5, 3, 14}, {1, 5, 2, 4}});
    Matrix B = new Matrix(new double[] {1, 22, 2, 3});

    // MatrixSystem system = new MatrixSystem(A, B);
    // system.calculateLUP();
    // system.calculateZ();
    // system.calculateX();
    // println(system.solve());
    // system.L.printMatrix(2);
    // system.U.printMatrix(2);
    // system.P.printMatrix(2);
    // mult(mult(system.P, system.L), system.U).printMatrix(4);
    // mult(system.P, A).printMatrix(4);
    // system.solveMatrix().printMatrix();

    // matrix1.printMatrix();
    // matrix2.printMatrix();

    // mult(matrix1, matrix2).printMatrix();
    // println(matrix2.determinant());
    // println(millis());
    mult(inverse(A), A).printMatrix(4);
    // println(millis());
    // double[][][] matrices = decomposeLUP(A);
    // printMatrix(matrices[0], 2);
    // printMatrix(matrices[1], 2);
    // printMatrix(matrices[2], 2);
    // // printMatrix(matrices[2], 3);

    // Matrix L = new Matrix(matrices[0]);
    // Matrix U = new Matrix(matrices[1]);
    // Matrix P = new Matrix(matrices[2]);

    // mult(L, U).printMatrix(2);
    // mult(P, A).printMatrix(2);
    // A.transpose();
    // A.printMatrix(3);

    // println();

    // println(LUPSolve(A, B));

    // curve = new CubicCurve(0, 1, 0, 0, -width / 2, width / 2);
}

void draw()
{
    // pushMatrix();
    // translate(width / 2, height / 2);
    // curve.draw(color(0));
    // popMatrix();
}

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