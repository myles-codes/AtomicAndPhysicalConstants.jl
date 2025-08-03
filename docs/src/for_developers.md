# For Developers: Code Logic

## Species

We provide a type `Species` for simple access to atomic and subatomic particle data. The constructor `Species(::String)` creates a `Species` instance from a given name. Users can retrieve data through getter functions such as `massof()` and `chargeof()`.

```julia
julia> e = Species("electron") # create an "electron" Species

julia> @APCdef unittype = Unitful # specify return units and type of the getter functions via @APCdef

julia> massof(e) # get the electron mass
510998.95069 eV c⁻²

julia> chargeof(e) # get the electron charge
-1.0 e

```

### Species Type Internal Structure

The `Species` type contains the following fields, defined in [types.jl](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/blob/main/src/types.jl)


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

```julia
struct Species
  name::String # name of the particle to track
  charge::typeof(1u"e") # charge of the particle, unit [e]
  mass::typeof(1.0u"MeV/c^2") # mass of the particle, unit in [eV/c^2]
  spin::typeof(1.0u"h_bar") # spin of the particle, unit in [ħ]
  moment::typeof(1.0u"J/T") # magnetic moment of the particle (for now it's 0 unless we have a recorded value), unit in [J/T]
  iso::Float64 # if the particle is an atomic isotope, this is the mass number, otherwise 0
  kind::Kind.T #The kind field classifies species into five types: ATOM, HADRON, LEPTON, PHOTON, and NULL.
end
```

Note that `charge`, `mass`, `spin`, and `moment` are stored as `Unitful.Quantity` types with specific units, as indicated in the comments.

### Species Data storage

All possible `Species` data is stored internally. When the constructor `Species(::String)` is called, it retrieves this data to build a new `Species`.

Information about subatomic and atomic particles is stored in two structs: `SubatomicSpecies` and `AtomicSpecies`. Dictionary maps link particle names (as strings) to these structures. The structs are defined in [types.jl](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/blob/main/src/types.jl), and the dictionaries are defined in [subatomic_species.jl](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/blob/main/src/subatomic_species.jl) and [isotopes.jl](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/blob/main/src/isotopes.jl). 

`SubatomicSpecies` has the following fields

```julia
struct SubatomicSpecies
  species_name::String              # common species_name of the particle
  charge::typeof(1.0u"e")           # charge on the particle, in units of [e]
  mass::typeof(1.0u"MeV/c^2")       # mass of the particle, in units of [eV/c^2]
	moment::typeof(1.0u"J/T")         # magnetic moment, in units of [J/T]
  spin::typeof(1.0u"h_bar")         # spin magnetic moment, in units of [ħ]
end;
```

`AtomicSpecies` has the following fields

```julia
struct AtomicSpecies
  Z::Int64                           # number of protons
  species_name::String               # periodic table element symbol
  mass::Dict{Int64,typeof(1.0 * u"amu")}  # a dict to store the masses, keyed by isotope
end
```

**Note:** mass is a dictionary that maps mass number to isotope mass. `-1` maps to the average mass of common isotopes. Only existing isotopes is a key in the dictionary.

The function `subatomic_particle(name::String)` searches for a subatomic particle with corresponding `name` in the dictionary and builds a `Species` from `SubatomicSpecies`.

Similarly, `create_atomic_species(name::String, charge::Int, iso::Int)` searches for an atomic particle with corresponding `name` and `iso` in the dictionary and builds a `Species` with the corresponding `mass` and charge. Other fields—`spin`, `moment`, and `kind`—are computed accordingly.

### Species Constructor

The constructor parses the `name` and creates the according `Species`.

The constructor follows this order for parsing the `name`.

- Check whether it is a `Null Species`, if yes then creates a `Null Species` by setting `kind` to `NULL`
- Check whether they are Anti-particles.
- Check whether it is a subatomic particles, if yes then use `subatomic_particle()` to create the `Species`.
- Check whether it is an atomic species.
    - Parse the `iso` number in front of the atomic symbol
    - Parse the `charge` number in the back of the atomic symbol
    - Call `create_atomic_species()` to create the `Species`.

## @APCdef

`@APCdef` configures physical constants and `Species` getter functions using the specified:

- Unit system
- Return type (`Float`, `Unitful`, or `DynamicQuantities`)
- Tuple name
- Tuple output flag (whether to wrap constants in a tuple

### 1 Predefined Unit Systems

For convient usage, we predefined 3 unit systems:

- `ACCELERATOR`: Uses high-energy physics units (`eV/c²`, `m`, `s`, `eV`, `e`)
- `MKS`: Standard SI units (`kg`, `m`, `s`, `J`, `C`)
- `CGS`: CGS units (`g`, `cm`, `s`, `J`, `C`)

```julia
@APCdef unitsystem = MKS
```

The user can specify a set of units quickly. 

Since users can also define their own unit system. The units of the tuple must be in the order of “mass unit”, “length unit”, “time unit”, “energy unit”, and “charge unit”. The unit dimension is checked in macro.

### 2 Ensuring Single Macro Call

Since `@APCdef` defines `massof()`, we check whether `@APCdef` is called in the module by check whether `massof()` is in the namespace.

### 3 Extract Keyword Arguements

Julia macro does accept keyword arguments, so the next section sets default values

- `unittype = :Float`
- `unitsystem = ACCELERATOR`
- `name = :APC`
- `tupleflag = true`

And extracts keyword arguement variables from the marco expression input.

### 4 Collecting Constants

- Extracts constants from the parent module whose names start with `__b_` and are not intermediate variables (e.g., those containing `_m_`).
- Converts them to appropriate units based on the `conversion` dictionary.
- Constructs a dictionary `constantsdict` with transformed values.

### 5 Unit Type Conversion

Based on `unittype`:

- **`:Unitful`**: Constants retain their units.
- **`:Float`**: Extracts `.val` from quantities, stripping units.
- **`:DynamicQuantities`**: Converts values into `DynamicQuantities.Quantity`

### 6 Output Format: Tuple or Individual Variables

Determined by `tupleflag`:

- `true` → constants are packed into a `NamedTuple` under the given module name.
- `false` → constants are returned as independent global variables.

### 7 Generate Species Getter Functions

Generated via `generate_particle_property_functions(...)`:

- **`massof`**: Returns the mass of a `Species` or species name.
- **`chargeof`**: Returns the charge.
- **`spinof`**: Returns the spin (except for null or atomic species).
- **`nameof`**: Returns a species' name, including isotope/charge info unless `basename = true`.

### 8 Return statement

- `APCconsts` stores the macro-defined name.
- `UNITS` holds a `NamedTuple` mapping physical quantity symbols (`:mass`, `:length`, etc.) to their respective units.
- Species Getter Functions
- Constants (either wrapped in named tuple or not)