
# Constants 

## Available Constants
The macro `@APCdef` defines a set of physical constants with the provided set of units (For more details, see [this page](units.md)). The following example is how to use the macro and the physical constants.

```julia
julia> @APCdef
julia> C_LIGHT
2.99792458e8
```

### Constants Defined by @APCdef

- Speed of light: `C_LIGHT`
- Planck's constant: `H_PLANCK`
- Reduced Planck's constant: `H_BAR_PLANCK`
- Classical electron radius: `R_E`
- Classical proton radius: `R_P`
- Elementary charge:  `E_CHARGE`
- Vacuum permeability: `MU_0_VAC`
- Permittivity of free space: `EPS_0_VAC`
- Classical Radius Factor: `CLASSICAL_RADIUS_FACTOR`
- Fine structure constant: `FINE_STRUCTURE`
- Avogadro's constant: `N_AVOGADRO`

### Species Mass and Charge

To access mass or charge of a species, use `massof()` getter function for mass, and `chargeof()` getter function for charge. The function will return unit given to `@APCdef`. For Example:

```julia
julia> e = Species("electron") 

julia> @APCdef unitsystem = ACCELERATOR unitful = true # set units to ACCELERATOR unit system, where mass unit is eV/c^2 and charge unit is elementary charge

julia> massof(e) 
510998.95069 eV c⁻²

julia> chargeof(e)
-1.0 e

```

## Constants Sources and Updates

The data for the constants are provided by CODATA. Users have the freedom to choose the year of CODATA in `@APCdef`. For example: 
```julia
julia> @APCdef CODATA = 2018
```
The data are downloaded to the local file.

The isotope data are provided by NIST. We extract the isotope data from their database. The NIST doesn't store old releases, so the isotope data will always be the newest release.

The pion0 and pion+- data are provided by PDG(Particle Data Group). We extracted the data from the database of **pdgapi.lbl.gov**