# Constants 

## Available Constants

The macro `@APCdef` defines a set of physical constants with the provided set of units (For more details, see [this page](units.md). The following example is how to use the macro and the physical constants.

```julia
julia> using AtomicAndPhysicalConstants
julia> @APCdef
julia> APC.C_LIGHT
2.99792458e8
```

## Constants Defined by @APCdef

- Speed of light: `C_LIGHT`
- Planck's constant: `H_PLANCK`
- Reduced Planck's constant: `H_BAR_PLANCK`
- Classical electron radius: `R_E`
- Classical proton radius: `R_P`
- Elementary charge: `E_CHARGE`
- Vacuum permeability: `MU_0_VAC`
- Permittivity of free space: `EPS_0_VAC`
- Classical Radius Factor: `CLASSICAL_RADIUS_FACTOR`
- Fine structure constant: `FINE_STRUCTURE`
- Avogadro's constant: `N_AVOGADRO`

## Listing Constants: `showconst()`

The `showconst()` function displays all available constants in the package.

There are three options:

```julia
julia> showconst() 
#list all the physical constants created by @APCdef
julia> showconst(:subatomic) 
#list all possible subatomic particles
julia> showconst(:Fe) 
# ':Fe' can be replaced by any atomic symbols
# list all the available isotopes of that element
```

## Species Mass and Charge

To access mass or charge of a species, use `massof()` getter function for mass, and `chargeof()` getter function for charge. The function will return unit given to `@APCdef`. For Example:

```julia
julia> e = Species("electron")

julia> @APCdef unitsystem = ACCELERATOR unittype = Unitful
# set units to ACCELERATOR unit system, where mass unit is eV/c^2 and charge unit is elementary charge

julia> massof(e)
510998.95069 eV c⁻²

julia> chargeof(e)
-1.0 e

```

### Atomic mass and Electron binding energies

Unfortunately, Atomic and Isotopic masses do not scale perfectly to reality; we haven't been able to account for binding energies of electrons in varying shells in this code.
As a result, the mass of any given isotope in any charge state is taken to be the mass of the neutrally charged isotope (from NIST) plus or minus the requisite number of 
electron masses.

## Constants Sources and Updates

- The constants data comes from CODATA. You can choose which year of CODATA values to use through different submodules. If not specified, it defaults to CODATA2022. For example:

```julia
julia> using AtomicAndPhysicalConstants.CODATA2018 #use CODATA2018 values
julia> using AtomicAndPhysicalConstants #use CODATA2022 values
```

- NIST provides the isotope data, which we extract from their database. Since NIST doesn't maintain old releases, the isotope data always reflects their latest release.
- The pion0 and pion± data comes from PDG (Particle Data Group). We extract this data from the database at [pdgapi.lbl.gov](http://pdgapi.lbl.gov)
