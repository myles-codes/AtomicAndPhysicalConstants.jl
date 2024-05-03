using AtomicAndPhysicalConstants
using Test

@testset "AtomicAndPhysicalConstants.jl" begin
    # Write your tests here.
    @test !@isdefined c_light
    setunits()
    @test c_light == 2.99792458e8
    @test e_charge == 1
end
