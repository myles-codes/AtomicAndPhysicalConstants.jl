# AtomicAndPhysicalConstants.jl
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://bmad-sim.github.io/AtomicAndPhysicalConstants.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://bmad-sim.github.io/AtomicAndPhysicalConstants.jl/dev/)
[![Build Status](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml?query=branch%3Amain)



`AtomicAndPhysicalConstants.jl` is a Julia package designed to provide atomic and physical constants including things like the speed of light, subatomic particle properties, atomic isotope properties, etc. 

Values are obtained from CODATA (Committee on Data of the International Science Council), NIST (National Institute of Standards and Technology), and PDG (Particle Data Group). This package enables users to access and customize units for the constants. 

The package is compatible with Julia's Unitful.jl library for convenient unit manipulation. 

`AtomicAndPhysicalConstants.jl` has the following main features and advantages:

1. **Speed**: `GTPSA.jl` is significantly faster than `ForwardDiff.jl` for 2nd-order calculations and above, and has very similar performance at 1st-order
2. **Easy Monomial Indexing**: Beyond 2nd order, accessing/manipulating the partial derivatives in an organized way can be a significant challenge when using other AD packages. In GTPSA, three simple indexing schemes for getting/setting monomial coefficients in a truncated power series is provided, as well as a `cycle!` function for cycling through all nonzero monomials
3. **Custom Orders in Individual Variables**: Other packages use a single maximum order for all variables. With GTPSA, the maximum order can be set differently for individual variables, as well as for a separate part of the monomial. For example, computing the Taylor expansion of $f(x_1,x_2)$ to 2nd order in $x_1$ and 6th order in $x_2$ is possible
4. **Complex Numbers**: GTPSA natively supports complex numbers and allows for mixing of complex and real truncated power series
5. **Distinction Between State Variables and Parameters**: Distinguishing between dependent variables and parameters in the solution of a differential equation expressed as a power series in the dependent variables/parameters can be advantageous in analysis

## Setup


## Basic Usage
First, to define physical constants, call the macro `@APCdef`. 

```julia
julia> @APCdef
julia> C_LIGHT
2.99792458e8
```


Next, to create a species.

```julia
using GTPSA

# Descriptor for TPSA with 2 variables to 6th order
d = Descriptor(2, 6)

# Get the TPSs corresponding to each variable based on the Descriptor
x = vars(d)
# x[1] corresponds to the first variable and x[2] corresponds to the second variable

# Manipulate the TPSs as you would any other mathematical variable in Julia
f = cos(x[1]) + im*sin(x[2])
# f is a new ComplexTPS64
```

Note that scalars do not need to be defined as TPSs when writing expressions. Running `print(f)` gives the output

```
ComplexTPS64:
 Real                     Imag                       Order   Exponent
  1.0000000000000000e+00   0.0000000000000000e+00      0      0   0
  0.0000000000000000e+00   1.0000000000000000e+00      1      0   1
 -5.0000000000000000e-01   0.0000000000000000e+00      2      2   0
  0.0000000000000000e+00  -1.6666666666666666e-01      3      0   3
  4.1666666666666664e-02   0.0000000000000000e+00      4      4   0
  0.0000000000000000e+00   8.3333333333333332e-03      5      0   5
 -1.3888888888888887e-03   0.0000000000000000e+00      6      6   0
```

The GTPSA library currently only supports truncated power series representing `Float64` and `ComplexF64` number types.

For more details, including using TPSs with differing truncation orders for each variable, see the [GTPSA documentation](https://bmad-sim.github.io/GTPSA.jl/).
