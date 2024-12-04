
# Constants 

## Available Constants
Constants are accessed by a getter function. If a unit is provided, then the value with that unit is returned. If units is not provided, then the units will be in the units determined by `setunits()`. For Example:

```julia
julia> @APCdef
julia> c_light
2.99792458e8
```

### Constants Defined by @APCdef

#### Speed of light: `C_LIGHT`
#### Planck's constant: `H_PLANCK`
#### Reduced Planck's constant: `H_BAR_PLANCK`
#### Classical electron radius: `R_E`
#### Classical proton radius: `R_P`
#### Elementary charge:  `E_CHARGE`
#### Vacuum permeability: `MU_0_VAC`
#### Permittivity of free space: `EPS_0_VAC`
#### Classical Radius Factor: `CLASSICAL_RADIUS_FACTOR`
#### Fine structure constant: `FINE_STRUCTURE`
#### Avogadro's constant: `N_AVOGADRO`

### Species Mass and Charge

To access mass or charge of a species, use `massof()` getter function for mass, and `chargeof()` getter function for charge. Similarly, if a unit is not provided, the function will return unit defined by `setunits()`. For Example:

```julia
julia> e = Species("electron") 

julia> @APCdef unitful = true # set units to ACCELERATOR unit system, where mass unit is eV/c^2 and charge unit is elementary charge

julia> massof(e) 
510998.95069 eV c⁻²

julia> chargeof(e)
-1.0 e

```

## Constants Sources and Updates

The data for the constants are provided by CODATA. Users have the freedom to choose the year of CODATA in `@APCdef`. For example: 
```julia
julia> @APC CODATA = 2018
```
The data are downloaded to the local file.

The isotope data are provided by NIST. The way we obtain data is by

The pion0 and pion+- data are provided by PDG(Particle Data Group). We extracted the data from the database of **pdgapi.lbl.gov**
