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
setunits

macro setunits(unitsystem=ACCELERATOR)
  return quote
    local mass_unit = $(esc(unitsystem))[1]
    local length_unit = $(esc(unitsystem))[2]
    local time_unit = $(esc(unitsystem))[3]
    local energy_unit = $(esc(unitsystem))[4]
    local charge_unit = $(esc(unitsystem))[5]
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
    global $(esc(:C_LIGHT)) = uconvert(length_unit / time_unit, $__b_c_light)
    global $(esc(:H_PLANCK)) = uconvert(energy_unit * time_unit, $__b_h_planck)
    global $(esc(:H_BAR_PLANCK)) = uconvert(energy_unit * time_unit, $__b_h_bar_planck)
    global $(esc(:R_E)) = uconvert(length_unit, $__b_r_e)
    global $(esc(:R_P)) = uconvert(length_unit, $__b_r_p)
    global $(esc(:E_CHARGE)) = uconvert(charge_unit, $__b_e_charge)
    global $(esc(:massof)) = (species::Species, unit::Union{Unitful.FreeUnits,Nothing}=nothing) -> unit === nothing ? uconvert(mass_unit, species.mass) : uconvert(unit, species.mass)
    global $(esc(:chargeof)) = (species::Species, unit::Union{Unitful.FreeUnits,Nothing}=nothing) -> unit === nothing ? uconvert(charge_unit, species.mass) : uconvert(unit, species.mass)
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

const massof = nothing

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

const chargeof = nothing

const C_LIGHT = nothing
const H_PLANCK = nothing
const H_BAR_PLANCK = nothing
const R_E = nothing
const R_P = nothing
const E_CHARGE = nothing


function c_light(unit::Unitful.FreeUnits)
  return __b_c_light |> unit
end

function h_planck(unit::Unitful.FreeUnits)
  return __b_h_planck |> unit
end


function h_bar_planck(unit::Unitful.FreeUnits)
  return __b_h_bar_planck |> unit
end


function r_e(unit::Unitful.FreeUnits)
  return __b_r_e |> unit
end

function r_p(unit::Unitful.FreeUnits)
  return __b_r_p |> unit
end

function e_charge(unit::Unitful.FreeUnits)
  return __b_e_charge |> unit
end


function mu_0_vac()
  return __b_mu_0_vac
end

function mu_0_vac(unit::Unitful.FreeUnits)
  return __b_mu_0_vac |> unit
end


function eps_0_vac()
  return __b_eps_0_vac
end

function eps_0_vac(unit::Unitful.FreeUnits)
  return __b_eps_0_vac |> unit
end

function classical_radius_factor()
  return __b_classical_radius_factor
end

function fine_structure()
  return __b_classical_radius_factor
end

function N_avogadro()
  return __b_N_avogadro
end