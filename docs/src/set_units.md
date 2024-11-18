# setunits()
## Description

`setunits()` should be called at the initialization of the package. `setunits()` sets the units for physical constants, species mass and charge. 

The user have the freedom to choice the unit they want for `mass`, `length`, `time`, `energy`, and `charge`. Or, they can use our predefined unitsystems `ACCELERATOR` (default), `MKS`, and `CGS` to quickly setup the units. The units are of type `Unitful.FreeUnits`. See more about `Unitful` [here](#unitful).

`setunits()` will return an array with units for each dimension.


## Syntax
```julia
setunits(unitsystem;
  mass_unit,
  length_unit,
  time_unit,
  energy_unit,
  charge_unit,
)
```
## Options

## Examples
```julia
setunits() #sets unit system to ACCELERATOR (default).
```
```julia
setunits(mass_unit=u"kg", charge=u"e") #sets unit system to ACCELERATOR (default), but mass unit in "kg".
```
```julia
setunits(MKS) #sets unit system to MKS.
```
```julia
setunits(CGS, mass_unit=u"kg", charge=u"e") #sets unit system to CGS, but mass unit in "kg" and charge unit in elementary charge.
```
## Unitful


