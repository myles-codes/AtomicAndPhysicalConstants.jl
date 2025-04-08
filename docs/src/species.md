# Species

# **Species**

## **Introduction**

`Species` is a type that stores information about a particle.

A species is defined by the following fields:

```julia
struct Species
    name   # name of the particle to track
    charge # charge of the particle
    mass   # mass of the particle
    spin   # spin of the particle
    moment # magnetic moment of the particle
    iso    # mass number of atomic isotope
    kind   # the kind of particle
end
```

The `kind` field classifies species into five types: `ATOM`, `HADRON`, `LEPTON`, `PHOTON`, and `NULL`. The `NULL` kind serves as a placeholder for a null species.

Each field stores values with their corresponding units and returns a Unitful value when accessed directly. For example:

```julia
julia> Species("electron").mass
0.51099895069 MeV c^-2
```

The default units are:

- `mass`: MeV/c²
- `charge`: elementary charge
- `spin`: ℏ
- `moment`: J/T

For convenience, use our getter functions `massof()` and `chargeof()` to obtain values in your preferred units. See this page for more information.

[Constants](constants.md)

## **Construct a Species**

Use the constructor `Species(name)` to create a species.

**Note**: Species names follow the OpenPMD standard.

### **Constructing a Null species**

The `Null` species is useful for bookkeeping purposes, such as a placeholder in a struct component to indicate an unset species. To instantiate:

```julia
julia> Species("Null")
julia> Species() # Same as above
```

### **Constructing Subatomic Species**

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

### **Constructing Atomic Species**

To construct an atomic species, include these components in `name`:

- Atomic Symbol
- Mass number of the atom (optional), format:
    - Mass number before the atomic symbol (accepts unicode superscript)
    - Optional "#" symbol at the beginning
    - If not specified, uses the most abundant isotope
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
    - "--" for double negative charge
    - "-n" or "n-" for n negative charges
    - Defaults to 0 if not specified
- Add "anti-" prefix to construct an anti-atom

Example:

```julia
julia> Species("13C+")#Carbon-13 with a single positive charge
julia> Species("¹⁵N³⁻")#Nitrogen-15 with a 3 negative charge
julia> Species("Al+3")#average Aluminum with 3 positive charge
julia> Species("anti-H")#anti-hydrogen
```

## **Species Functions**

Species functions each take a `Species` as their parameter and return a specific property. Here are the available functions:

- `massof()`
- `chargeof()`
- `atomicnumber()`
- `g_spin()`
- `gyromagnetic_anomaly()`
- `g_nucleon()`
- `fullname()`

**Note**: You must call `@APCdef` before using `massof()` or `chargeof()`.

## **List of Available Subatomic Species**

- `photon`
- `pion0`
- `pion+`
- `pion-`
- `muon`
- `anti-muon`
- `electron`
- `positron` or `anti-electron`
- `proton`
- `anti-proton`
- `neutron`
- `anti-neutron`
- `deuteron`
- `anti-deuteron`