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
  # sort and collect the dictionary
  # since elements in the dictionary does not have a preferred order, sorting it increases stability
  # pairs_sorted is an array of key and value pair of the CONSTANTS dictionary
  pairs_sorted = sort(collect(CONSTANTS), by=x -> first(x))
  # generate the field of the structure
  # the name of the field is the key of the dictionary, i.e. symbols with capitalized names
  # the type of the field is "Union{Quantity,Float64}", meaning that it could either be an Unitful Quantity or a Float, depending
  # on user's choice
  # fields is an array with elements are expressions like "C_LIGHT::Union{Quantity,Float64}"
  fields = [:($key::Union{Quantity,Float64}) for (key, _) in pairs_sorted]

  # define the structure with the field name as the constants name
  struct_name = :ConstantsStructure # the name of the structure is ConstantsStructure
  @eval struct $struct_name
    $(fields...) # put the fields into the structure
  end

  return quote
    #default parameter
    CODATA = 2022
    unitsystem = $ACCELERATOR
    unitful = false
    #evaluate the parameter
    $(exs...)

    # extract the units from the unit system
    mass_unit::Unitful.FreeUnits = unitsystem[1]
    length_unit::Unitful.FreeUnits = unitsystem[2]
    time_unit::Unitful.FreeUnits = unitsystem[3]
    energy_unit::Unitful.FreeUnits = unitsystem[4]
    charge_unit::Unitful.FreeUnits = unitsystem[5]
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

    # this dictionary maps the dimension of the unit to the target unit that it should convert to
    conversion = Dict(
      dimension(u"kg") => mass_unit,
      dimension(u"m") => length_unit,
      dimension(u"s") => time_unit,
      dimension(u"J") => energy_unit,
      dimension(u"C") => charge_unit,
      dimension(u"m/s") => length_unit / time_unit,
      dimension(u"J*s") => energy_unit * time_unit,
      dimension(u"kg*m") => mass_unit * length_unit,
      dimension(u"m") => length_unit,
      dimension(u"C") => charge_unit,
    )


    # generate the constructor parameter of the structure, converted to new units
    values = [
      if haskey(conversion, dimension(v)) #if the dimension is one of the dimensions in the dictionary
        if unitful
          uconvert(conversion[dimension(v)], v) # if the user demands unitful quantity, return unitful quantity
        else
          uconvert(conversion[dimension(v)], v).val # if the user demands Float, convert and return Float
        end
      else
        if unitful # whether user wants a unitful quantity 
          v # if the unit dimension is not in the dictionary such as that of eps_0_vac, then just return the unit without any conversion
        elseif v isa Float64 # If the value does not have unit, such as Avogadro's number
          v
        else #If the user demands values in Float64
          v.val
        end
      end
      for (_, v) in $pairs_sorted # for all the values in the dictionary
    ]

    # initialize the structure with the constructor and values
    $(esc(name))::$ConstantsStructure = $ConstantsStructure(values...)

    #massof and charge of
    function $(esc(:massof))(species::Species)::Union{Float64,Quantity,Int64}
      @assert species.mass isa Quantity
      return unitful ? uconvert(mass_unit, species.mass) : uconvert(mass_unit, species.mass).val
    end
    function $(esc(:chargeof))(species::Species)::Union{Float64,Quantity,Int64}
      @assert species.charge isa Quantity
      return unitful ? uconvert(charge_unit, species.charge) : uconvert(charge_unit, species.charge).val
    end

    #added options for string input
    function $(esc(:massof))(speciesname::String)::Union{Float64,Quantity,Int64}
      species = Species(speciesname)
      return unitful ? uconvert(mass_unit, species.mass) : uconvert(mass_unit, species.mass).val
    end
    function $(esc(:chargeof))(speciesname::String)::Union{Float64,Quantity,Int64}
      species = Species(speciesname)
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