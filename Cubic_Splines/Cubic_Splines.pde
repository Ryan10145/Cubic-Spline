CubicCurve curve;

void setup()
{
    size(1000, 600);

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
    //                                             {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12},});
    // Matrix A = new Matrix(new double[][] {{1, 1, 1}, {4, 3, -1}, {3, 5, 3}});
    // Matrix C = new Matrix(new double[] {1, 6, 4});

    // MatrixSystem system = new MatrixSystem(A, C);
    // println(system.solve());

    // matrix1.printMatrix();
    // matrix2.printMatrix();

    // mult(matrix1, matrix2).printMatrix();
    // println(matrix2.determinant());

    curve = new CubicCurve(0, 1, 0, 0, -width / 2, width / 2);
}

void draw()
{
    pushMatrix();
    translate(width / 2, height / 2);
    curve.draw(color(0));
    popMatrix();
}
