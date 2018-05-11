void setup()
{
    // size(1000, 600);

    Matrix matrix1 = new Matrix(new double[][] {{10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12}, 
                                                {10, 25, 30, 25, 30, 25, 30, 25, 30, 25, 30, 12},});
    Matrix matrix2 = new Matrix(new double[][] {{2, -1, -2}, {-4, 6, 3}, {-4, -2, 8}});

    // matrix1.printMatrix();
    // matrix2.printMatrix();

    // mult(matrix1, matrix2).printMatrix();
    println(matrix2.determinant());
}

void draw()
{
    //https://www.gamedev.net/articles/programming/math-and-physics/matrix-inversion-using-lu-decomposition-r3637/
}
