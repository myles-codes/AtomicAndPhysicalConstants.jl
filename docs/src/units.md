# Setting Units for Constants And Particle Functions, Basic Unitful Usage

## @APCdef
### Description

`@APCdef` should be called at the initialization of the package. `@APCdef` sets the units for physical constants, species mass and charge. It defines the physical constants and getter functions for species mass and charge with the proper unit and data, see [this page](constants.md) for more detail.

The user have the freedom to choose the unit they want for `mass`, `length`, `time`, `energy`, and `charge`. by using our predefined unitsystems `ACCELERATOR` (default), `MKS`, and `CGS` to quickly setup the units.

The users have the freedom to choose the version of CODATA they prefer.

The users have the freedom to choose whether they want the constants to be of type `Float64` or Unitful types, which makes unit calculations easier. See more about `Unitful` [here](#unitful).


### Syntax
```julia
@APCdef(CODATA = 2022, unitsystem = ACCELERATOR, unitful = false)
```
### Options

`CODATA` sets the year of which the constants from CODATA is used. Enter the year number. Default to 2022.

`unitsystem` defines the set of units for the constants. There are 3 available options: `ACCELERATOR`,`MKS`,`CGS`. Default to `ACCELERATOR`.

`unitful` is a boolean. If it is set to `true`, the constants will be a Unitful type. If it is set to `false`, it will be a `Float64`. Default to `false`.

`ACCELERATOR` units:
- `mass`: eV/c^2
- `length`: m
- `time`: s
- `energy`: eV
- `charge`: elementary charge

`MKS` units:
- `mass`: kg
- `length`: m
- `time`: s
- `energy`: J
- `charge`: C

`CGS` units:
- `mass`: g
- `length`: cm
- `time`: s
- `energy`: J
- `charge`: C

### Example
```julia
julia> @APCdef # Sets unit system to ACCELERATOR (default). define constants with type Float64
julia> C_LIGHT
2.99792458e8 # Now the constant C_LIGHT is defined with units m/s and type Float64.
```

## Unitful

[Unitful.jl](https://github.com/PainterQubits/Unitful.jl) is a powerful package for managing physical units.

### Units

Unitful uses the macro `@u_str` to create units. 
```julia
julia> kg = u"kg"
```
The variable `kg` represents the unit kilogram.

To create constants with units, simply write the number in front of the unit.
```julia
julia> M = 1u"kg"
```

Now `M` is a variable that represents 1 kilogram.

### Conversion to Float

To convert a Unitful object to Float64, use the field `.val`
```julia
julia> a = 1.5u"kg"
julia> a.val
1.5
```

### Unit Conversions

Unitful provides a convenent way to create new units with expressions. Prefix can also be directly added.
```julia
julia> m = 0.511u"MeV/c^2"
```
To convert between units, use the function `uconvert()`, putting the new unit in the first parameter and the variable in the second parameter.
```julia
julia> uconvert(u"kg",m)
9.109402419518556e-31 kg
```

### Package-specific Units

`AtomicAndPhysicalConstants` defined 3 units that is not from the Unitful package. Within the package, users can directly use `@u_str` macro to access these units, just like any other units.

- `amu` : It represents the atomic mass unit. 

- `e` : It represents the elementary charge.

- `h_bar` : It represents the reduced Planck's constant. It is used as the unit for spin.
