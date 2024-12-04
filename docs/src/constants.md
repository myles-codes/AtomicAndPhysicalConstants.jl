
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
#### Vacuum permeability: `mu_0_vac()`
#### Permittivity of free space: `eps_0_vac()`
#### Classical Radius Factor: `classical_radius_factor()`
#### Fine structure constant: `fine_structure()`
#### Avogadro's constant: `N_avogadro()`

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