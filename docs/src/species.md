# Species

## Introduction

`Species` is a type that stores information about a particle.

A `Species` stores the following information:

- `name`: name of the particle to track
- `charge`: charge of the particle
- `mass`: mass of the particle
- `spin`: spin of the particle
- `moment`: magnetic moment of the particle
- `iso`: mass number of atomic isotope
- `kind`: The `kind` field classifies species into five types: `ATOM`, `HADRON`, `LEPTON`, `PHOTON`, and `NULL`.

**Note**: The `NULL` kind serves as a placeholder that can be used by Julia code. For example, if a `struct`
has a `Species` component, a `NULL` species can be used as an initial value to indicate that the
species component has not yet been set.


## Getter Functions
To access mass or charge of a species, use `massof()` getter function for mass, and `chargeof()` getter function for charge. The function will return unit given to [`@APCdef`](units.md). See this [page](constants.md) for more information.

Use the function `nameof()` to access the species name.

## Construct a Species

Use the constructor `Species(::String)` to create a species.

**Note**: Species names follow the OpenPMD standard.

### Constructing a Null Species

The `Null` species is useful for bookkeeping purposes, such as a placeholder in a struct component to indicate an unset species. To instantiate:

```julia
julia> Species("Null")
julia> Species() # Same as above
```

### Constructing Subatomic Species

To construct a subatomic species, provide the exact name of the particle in the `name` field. **Note that the name must be provided exactly.**

Example:

```julia
julia> Species("electron")
```

For antiparticles, prepend "anti-" to the name.

Example:

```julia
julia> Species("anti-proton")
```

See the [list of all available subatomic species](#list-of-available-subatomic-species) at the end of this page.

### Constructing Atomic Species

To construct an atomic species, include these components in `name`:

- Atomic Symbol
- Mass number of the atom (optional), format:
    - Mass number before the atomic symbol (accepts unicode superscript)
    - Optional "#" symbol at the beginning
    - If not specified, uses the average of the mass in naturally occurring samples.
- These formats all represent Hydrogen-1:
    
```julia
julia> Species("1H")
julia> Species("¹H")
julia> Species("#1H")
```
    
- Charge (optional), format (all accept unicode superscript):
    - "+" for single positive charge
    - "++" for double positive charge
    - "+n" or "n+" for n positive charges
    - "-" for single negative charge
    - "-\-" for double negative charge
    - "-n" or "n-" for n negative charges
    - Defaults to 0 if not specified
- Add "anti-" prefix to construct an anti-atom

Example:

```julia
julia> Species("13C+")   # Carbon-13 with a single positive charge
julia> Species("¹⁵N³⁻")  # Nitrogen-15 with a 3 negative charge
julia> Species("Al+3")   # Average Aluminum with 3 positive charge
julia> Species("anti-H") # Anti-hydrogen
```

## List of Available Subatomic Species

- `anti-deuteron`
- `anti-electron` or `positron`
- `anti-neutron`
- `anti-proton`
- `anti-muon`
- `deuteron`
- `electron`
- `muon`
- `neutron`
- `photon`
- `pion0`
- `pion+`
- `pion-`
- `positron`
- `proton`
