# Species

### Introduction

A species is defined with the following fields:

```julia
struct Species 
    name    # name of the particle to track
    charge  # charge of the particle 
    mass    # mass of the particle
    spin    # spin of the particle
    moment  # magnetic moment of the particle
    iso     # mass number of atomic isotope
	populated
end;
```
The fields are stored with a set of units. If the fields are directly accessed, it will return a unitful value. For example:
```julia
julia> Species("electron").mass
0.51099895069 MeV c^-2
```
The default units are:
- `mass`:  MeV/c^2
- `charge`: elementary charge
- `spin`: $\hbar$
- `moment`: J/T

We recommended using our getter functions `massof()` an d `chargeof()` to obtain values in units you prefer. See [this page](units.md) for more information.


### Construct a Species

How contructors works

### Particle Functions

mass of, charge of etc.

### List of Available subatomic species