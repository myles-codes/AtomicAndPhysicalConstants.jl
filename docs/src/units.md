# Setting Units for Constants And Particle Functions using @APCdef

## @APCdef Description

`@APCdef` must be called during package initialization. It sets the units for physical constants, 
species mass, and charge. 
The macro also defines physical constants in the appropriate units and creates getter functions 
for species mass and charge with appropriate units and data. See the [Species](species.md) page for more details.
**Note** `@APCdef` can only be called once.

Users can choose their preferred units for `mass`, `length`, `time`, `energy`, and `charge`
using predefined unit systems: `ACCELERATOR` (default), `MKS`, or `CGS`. 

Users can also specify whether constants should be of type `Float64` (default), `Unitful`, 
or `Dynamic Quantities` for easier unit calculations. 

All constants are stored in a named tuple by default, whose name can be customized (defaults to `APC`).
For example, the default name for the speed of light is `APC.C_LIGHT`.

Alternatively, users can set `tupleflag` to `false` to define constants as global variables in the namespace. This allows direct access to the constants without using the named tuple prefix.

## @APCdef Syntax

```julia
@APCdef(name = APC, unitsystem = ACCELERATOR, unittype = Float, tupleflag = true)
```

## Keyword Parameters

- `name` specifies the named tuple that stores the constants (default: `APC`).
- `unitsystem` sets the unit system for constants: `ACCELERATOR` (default), `MKS`, or `CGS`.
- `unittype` sets the constant type: `Float` (default), `Unitful`, or `DynamicQuantities`. 
This also determines the return type of both the named tuple and the `massof()` and `chargeof()` functions.
See the [`DynamicQuantities.jl`](https://github.com/SymbolicML/DynamicQuantities.jl) documentation
for a discussion of the difference between how `Unitful` and `DynamicQuatities` handle units.
**Note**: setting the unit type to `DynamicQuantities` will return quantities only in SI units.
- `tupleflag` determines whether to store constants in a named tuple (default: `true`).

## Unit Systems

- `ACCELERATOR` units:
    - `mass`: eV/c^2
    - `length`: m
    - `time`: s
    - `energy`: eV
    - `charge`: elementary charge
- `MKS` units:
    - `mass`: kg
    - `length`: m
    - `time`: s
    - `energy`: J
    - `charge`: C
- `CGS` units:
    - `mass`: g
    - `length`: cm
    - `time`: s
    - `energy`: J
    - `charge`: C
- Users can also define their own units by creating a tuple of Unitful units.
    - The tuple must be using the types in `Unitful`
    - The tuple must have 5 elements
    - The elements must be ordered in “mass unit”, “length unit”, “time unit”, “energy unit”, and “charge unit”.

## Example

```julia
julia> @APCdef  
# Sets unit system to ACCELERATOR (default). define constants with type Float64.

julia> APC.C_LIGHT  
# Access the constant within the named tuple `APC`.
2.99792458e8        
# Now the constant is defined with units m/s and type Float64.
julia> APC.E_CHARGE  
1.0         
# The default unit for charge is elementary charge.
```
```julia
julia> @APCdef unittype = Unitful unitsystem = MKS tupleflag = false 
# Define constants with type Unitful. Sets unit system to MKS. Do not wrap constants in a named tuple.

julia> E_CHARGE  
# Access the constant directly
1.602176634e-19 C        
# Now the constant is defined with units C and type Unitful.
```

# Unitful

[Unitful.jl](https://github.com/PainterQubits/Unitful.jl) is a powerful package for managing physical units. 
This package uses `Unitful` internally to store constants.

## Units

Unitful uses the macro `@u_str` to create units.

```julia
julia> kg = u"kg"
```

The variable `kg` represents the unit kilogram.

Creating constants with units is straightforward—simply write the number before the unit.

```julia
julia> M = 1u"kg"
```

Now `M` represents 1 kilogram.

## Conversion to Float

To convert a Unitful object to Float64, access the `.val` field.

```julia
julia> a = 1.5u"kg"
julia> a.val
1.5
```

## Unit Conversions

Unitful provides a convenient way to create new units with expressions. You can also add prefixes directly.

```julia
julia> m = 0.511u"MeV/c^2"
```

To convert between units, use the `uconvert()` function with the target unit as the first parameter and the variable as the second.

```julia
julia> uconvert(u"kg",m)
9.109402419518556e-31 kg
```

## @APCdef Returning `Unitful` Type

To use `Unitful`-typed constants, set `unittype` to `Unitful`.

```julia
julia> @APCdef unittype = Unitful 

julia> APC.C_LIGHT 
2.99792458e8 m s⁻¹ # Now the constant is a Unitful quantity.
```

# Package-specific `Unitful` Units

`AtomicAndPhysicalConstants` defines three custom units not found in the `Unitful` package. 
Users can access these units with the `@u_str` macro, just like standard `Unitful` units.

- `amu`: It represents the atomic mass unit.
- `e`: It represents the elementary charge.
- `h_bar`: It represents the reduced Planck's constant. It is used as the unit for spin.

## @APCdef Returning `DynamicQuantities.jl` Type

[DynamicQuantities.jl](https://github.com/SymbolicML/DynamicQuantities.jl) is another popular package for managing units. We also support returning constants in DynamicQuantities type.

```julia
julia> @APCdef unittype = DynamicQuantities

julia> APC.C_LIGHT 
2.99792458e8 m s⁻¹ # Now the constant is a DynamicQuantities quantity.
```

**Note**: setting the unit type to `DynamicQuantities` will return quantities only in `SI` units.