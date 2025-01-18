# Declare specific systems of units
#   for particle physics
"""
    ACCELERATOR
## ACCELERATOR units:
- `mass`: eV/c^2
- `length`: m
- `time`: s
- `energy`: eV
- `charge`: elementary charge
"""
ACCELERATOR

const ACCELERATOR = [
  u"eV/c^2",
  u"m",
  u"s",
  u"eV",
  u"e"]

#   MKS
"""
    MKS
## MKS units:
- `mass`: kg
- `length`: m
- `time`: s
- `energy`: J
- `charge`: C
"""
MKS

const MKS = [
  u"kg",
  u"m",
  u"s",
  u"J",
  u"C"]
#   quasi-CGS
"""
    CGS
## CGS units:
- `mass`: g
- `length`: cm
- `time`: s
- `energy`: J
- `charge`: C
"""
CGS

const CGS = [
  u"g",
  u"cm",
  u"s",
  u"J",
  u"C"]

"""
    @APCdef(CODATA = 2022, unitsystem = ACCELERATOR, unitful = false)

## Description:
It defines the physical constants and getter functions for species mass and charge with the proper unit and data.

## positional parameters:
- `CODATA`       -- type: `Int`. Specify the year of the data source. Default to `2022``
- `unitsystem`   -- type: `UnitSystem`. Specify the unit system, default to `ACCELERATOR`, which sets units to 'Default units' (see above).
                                        The other options are `MKS`, and `CGS`. It provides a convient way to set all the units.
- `unitful`      -- type: `Bool`. If it is set to `true`, the constants will be a Unitful type. If it is set to `false`, it will be a `Float64`. Defualt to `false`.
                        
    
## Default units:
- `mass`: eV/c^2
- `length`: m
- `time`: s
- `energy`: eV
- `charge`: elementary charge

"""
macro APCdef(name=:APC, exs...)
  #sort and collect the dictionary
  pairs_sorted = sort(collect(CONSTANTS), by=x -> first(x))
  # generate the field of the structure
  fields = [:($key::Union{Quantity,Float64}) for (key, _) in pairs_sorted]

  # define the structure with the field name as the constants name
  struct_name = :ConstantsStructure
  @eval struct $struct_name # fields are of type Float64
    $(fields...)
  end

  return quote
    #default parameter
    CODATA = 2022
    unitsystem = $ACCELERATOR
    unitful = false
    #evaluate the parameter
    $(exs...)

    mass_unit = unitsystem[1]
    length_unit = unitsystem[2]
    time_unit = unitsystem[3]
    energy_unit = unitsystem[4]
    charge_unit = unitsystem[5]
    # check dimensions of units
    if dimension(mass_unit) != dimension(u"kg")
      error("unit for mass does not have proper dimension")
    end
    if dimension(length_unit) != dimension(u"m")
      error("unit for length does not have proper dimension")
    end
    if dimension(time_unit) != dimension(u"s")
      error("unit for time does not have proper dimension")
    end
    if dimension(energy_unit) != dimension(u"J")
      error("unit for energy does not have proper dimension")
    end
    if dimension(charge_unit) != dimension(u"C")
      error("unit for charge does not have proper dimension")
    end

    # how units of a certain dimension gets converted
    conversion = Dict(
      dimension(u"m/s") => length_unit / time_unit,
      dimension(u"J*s") => energy_unit * time_unit,
      dimension(u"m") => length_unit,
      dimension(u"C") => charge_unit,
    )


    # generate the constructor parameter of the structure, converted to new units
    values = [
      if haskey(conversion, dimension(v))
        if unitful
          uconvert(conversion[dimension(v)], v)
        else
          uconvert(conversion[dimension(v)], v).val
        end
      else
        if unitful
          v
        elseif v isa Float64
          v
        else
          v.val
        end
      end
      for (_, v) in $pairs_sorted
    ]

    $(esc(name))::$ConstantsStructure = $ConstantsStructure(values...)

    #massof and charge of
    function $(esc(:massof))(species::Species)::Union{Float64,Quantity,Int64}
      return unitful ? uconvert(mass_unit, species.mass) : uconvert(mass_unit, species.mass).val
    end
    function $(esc(:chargeof))(species::Species)::Union{Float64,Quantity,Int64}
      return unitful ? uconvert(charge_unit, species.charge) : uconvert(charge_unit, species.charge).val
    end
    #$(esc(:chargeof2)) = begin
    #(species::Species) -> if species.populated == IsDef.Full
    #(unitful ? uconvert(charge_unit, species.charge) : uconvert(charge_unit, species.charge).val)
    # else
    # 	error("""Can't get the charge of an undefined particle; 
    # 	the Species constructor for this object was called with no arguments.""")
    #end
    #end
  end

end


"""
    massof(
      species::Species,
    )

## Description:
return mass of 'species' in current unit.

## parameters:
- `species`     -- type:`Species`, the species whose mass you want to know
"""
massof


"""
    chargeof(
      species::Species,
    )

## Description:
return charge of 'species' in current unit.

## parameters:
- `species`     -- type:`Species`, the species whose charge you want to know

"""
chargeof