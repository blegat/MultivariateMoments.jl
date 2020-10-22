using Test
using MultivariateMoments

# In SumOfSquares, we want the hermitian to be able to hold MOI variables for which
# im * MOI.VariableIndex(i) is not a Complex{MOI.VariableIndex}
# We test this with polynomials as it behaves similarly.

@testset "VectorizedHermitianMatrix with polynomial" begin
    Mod.@polyvar x y
    Q = VectorizedHermitianMatrix([x, x, x, y], 2)
    @test eltype(Q) == polynomialtype(x * y, Complex{Int})
    @test x == @inferred Q[1, 1]
    @test x + im * y == @inferred Q[1, 2]
    @test x - im * y == @inferred Q[2, 1]
    @test x == @inferred Q[2, 2]
end