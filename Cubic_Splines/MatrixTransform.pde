//Contains static methods for creating transformation matrices

public double[][] rotation(double angle)
{
    double[][] matrix = new double[2][2];
    matrix[0][0] = (double) cos((float) angle);
    matrix[0][1] = (double) -sin((float) angle);
    matrix[1][0] = (double) sin((float) angle);
    matrix[1][1] = (double) cos((float) angle);

    return matrix;
}

public Matrix rotationMatrix(double angle)
{
    return new Matrix(rotation(angle));
}