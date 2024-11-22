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


macro define_function(name, body)
  return :(function $(name)()
    $body
  end)
end



"""
    setunits(unitsystem::UnitSystem=ACCELERATOR;
      mass_unit::Unitful.FreeUnits=unitsystem.mass,
      length_unit::Unitful.FreeUnits=unitsystem.length,
      time_unit::Unitful.FreeUnits=unitsystem.time,
      energy_unit::Unitful.FreeUnits=unitsystem.energy,
      charge_unit::Unitful.FreeUnits=unitsystem.charge,
    )

## Description:
Return `nothing`.
Users can specify the unit system and modify units in the system by keyword parameters.
Sets global unit and store them in current units.
Prints current units at the end (optional).
    
## Default units:
- `mass`: eV/c^2
- `length`: m
- `time`: s
- `energy`: eV
- `charge`: elementary charge

## positional parameters:
- `unitsystem`   -- type: `UnitSystem`, specify the unit system, default to `PARTICLE_PHYSICS`, which sets units to 'Default units' (see above).
                                        The other options are `MKS`, and `CGS`. It provides a convient way to set all the units.

## keyword parameters
- `mass_unit`   -- type:`Union{Unitful.FreeUnits,AbstractString}`, unit for mass, default to the mass unit in `unitsystem`
- `length_unit` -- type:`Union{Unitful.FreeUnits,AbstractString}`, unit for length, default to the length unit in `unitsystem`
- `time_unit`   -- type:`Union{Unitful.FreeUnits,AbstractString}`, unit for time, default to the time unit in `unitsystem` 
- `energy_unit` -- type:`Union{Unitful.FreeUnits,AbstractString}`, unit for energy, default to the energy unit in `unitsystem`
- `charge_unit` -- type:`Union{Unitful.FreeUnits,AbstractString}`, unit for charge, default to the charge unit in `unitsystem`

## Note:
- unit for `Plancks' constant` is 'energy' * 'time'
- unit for `vacuum permeability` is N/A^2
- unit for `Permittivity of free space` is F/m
- unit for `Avogadro's number` is mol^-1
- unit for `classical radius` factor is 'length'*'mass'

"""
AAPCdef


macro AAPCdef(exs...)
  return quote
    #default parameter
    local CODATA = 2022
    local unitsystem = $ACCELERATOR
    local unitful = true
    #evaluate the parameter
    $(exs...)
    local mass_unit = unitsystem[1]
    local length_unit = unitsystem[2]
    local time_unit = unitsystem[3]
    local energy_unit = unitsystem[4]
    local charge_unit = unitsystem[5]
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
    const global $(esc(:C_LIGHT)) = unitful ? uconvert(length_unit / time_unit, $__b_c_light) : uconvert(length_unit / time_unit, $__b_c_light).val
    const global $(esc(:H_PLANCK)) = unitful ? uconvert(energy_unit * time_unit, $__b_h_planck) : uconvert(energy_unit * time_unit, $__b_h_planck).val
    const global $(esc(:H_BAR_PLANCK)) = unitful ? uconvert(energy_unit * time_unit, $__b_h_bar_planck) : uconvert(energy_unit * time_unit, $__b_h_bar_planck).val
    const global $(esc(:R_E)) = unitful ? uconvert(length_unit, $__b_r_e) : uconvert(length_unit, $__b_r_e).val
    const global $(esc(:R_P)) = unitful ? uconvert(length_unit, $__b_r_p) : uconvert(length_unit, $__b_r_p).val
    const global $(esc(:E_CHARGE)) = unitful ? uconvert(charge_unit, $__b_e_charge) : uconvert(charge_unit, $__b_e_charge).val
    const global $(esc(:massof)) = (species::Species) -> unitful ? uconvert(mass_unit, species.mass) : uconvert(mass_unit, species.mass).val
    const global $(esc(:chargeof)) = (species::Species) -> unitful ? uconvert(charge_unit, species.charge) : uconvert(charge_unit, species.charge).val
  end

end


"""
    massof(
      species::Species,
      unit::Union{Unitful.FreeUnits,AbstractString}=current_units.mass
    )

## Description:
return mass of 'species' in current unit or unit of the user's choice

## parameters:
- `species`     -- type:`Species`, the species whose mass you want to know
- `unit`        -- type:`Union{Unitful.FreeUnits,AbstractString}`, default to the unit set from setunits(), the unit of the mass variable

"""
massof


"""
    chargeof(
      species::Species,
      unit::Union{Unitful.FreeUnits,AbstractString}=current_units.charge
    )

## Description:
return charge of 'species' in current unit or unit of the user's choice

## parameters:
- `species`     -- type:`Species`, the species whose charge you want to know
- `unit`        -- type:`Union{Unitful.FreeUnits,AbstractString}`, default to the unit set from setunits(), the unit of the charge variable

"""
chargeof