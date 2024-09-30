
module NewUnits
using Unitful
AA = parentmodule(NewUnits)
@unit e "e" elementary_charge AA.__b_e_charge * u"C" false
@unit amu "amu" Amu (1 / (AA.__b_N_avogadro)) * u"g" false
end

Unitful.register(NewUnits);
using .NewUnits

function __init__()
  Unitful.register(NewUnits)
end


"""
    UnitSystem

## Description:
This defines an immutable struct for storing a specific
system of units.

## Fields:
- `mass`    -- type:`Unitful.FreeUnits`, stores the unit for mass
- `length`  -- type:`Unitful.FreeUnits`, stores the unit for length
- `time`    -- type:`Unitful.FreeUnits`, stores the unit for time
- `energy`  -- type:`Unitful.FreeUnits`, stores the unit for energy
- `charge`  -- type:`Unitful.FreeUnits`, stores the unit for charge
"""
UnitSystem

struct UnitSystem
  mass::Unitful.FreeUnits
  length::Unitful.FreeUnits
  time::Unitful.FreeUnits
  energy::Unitful.FreeUnits
  charge::Unitful.FreeUnits
end

# Declare specific systems of units
#   for particle physics
"""
    PARTICLE_PHYSICS::UnitSystem
## PARTICLE_PHYSICS units:
- `mass`: eV/c^2
- `length`: m
- `time`: s
- `energy`: eV
- `charge`: elementary charge
"""
PARTICLE_PHYSICS

const PARTICLE_PHYSICS = UnitSystem(
  u"eV/c^2",
  u"m",
  u"s",
  u"eV",
  u"e")

#   MKS
"""
    MKS::UnitSystem
## MKS units:
- `mass`: kg
- `length`: m
- `time`: s
- `energy`: J
- `charge`: C
"""
MKS

const MKS = UnitSystem(
  u"kg",
  u"m",
  u"s",
  u"J",
  u"C")
#   quasi-CGS
"""
    CGS::UnitSystem
## CGS units:
- `mass`: g
- `length`: cm
- `time`: s
- `energy`: J
- `charge`: C
"""
CGS

const CGS = UnitSystem(
  u"g",
  u"cm",
  u"s",
  u"J",
  u"C")

"""
    current_units :: UnitSystem

## Description:
This declares a `UnitSystem` that stores the units in current use.

## Note:
It is initialized when setunits() is called.
"""
current_units

"""
    getunits(unit::Symbol)

## Description:
return the unit with the corresponding field `unit` in `current_units`

## parameters:
- `unit`  -- type:`Symbol`, the name of the field in current_units.

"""
getunit

function getunit(unit::Symbol)
  if !@isdefined current_units
    throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
  else
    return getfield(current_units, unit)
  end
end

"""
    printunits()

## Description:
This function returns nothing. It simply prints the set of units
in current use.
"""
printunits

function printunits()
  if !@isdefined current_units
    throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
  end
  # prints the units for each dimensions
  println("mass unit:\t", current_units.mass)
  println("length unit:\t", current_units.length)
  println("time unit:\t", current_units.time)
  println("energy unit:\t", current_units.energy)
  println("charge unit:\t", current_units.charge)
  return
end

"""
    setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS;
      mass_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.mass,
      length_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.length,
      time_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.time,
      energy_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.energy,
      charge_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.charge,
      print_units::Bool = true
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

function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS;
  mass_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.mass,
  length_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.length,
  time_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.time,
  energy_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.energy,
  charge_unit::Union{Unitful.FreeUnits,AbstractString}=unitsystem.charge,
  print_units::Bool=true
)
  # convert types to Unitful.FreeUnits
  if mass_unit isa AbstractString
    mass_unit = uparse(mass_unit)
  end
  if length_unit isa AbstractString
    length_unit = uparse(length_unit)
  end
  if time_unit isa AbstractString
    time_unit = uparse(time_unit)
  end
  if energy_unit isa AbstractString
    energy_unit = uparse(energy_unit)
  end
  if charge_unit isa AbstractString
    charge_unit = uparse(charge_unit)
  end
  # check dimensions of units
  if dimension(mass_unit) != dimension(u"kg")
    throw(ErrorException("unit for mass does not have proper dimension"))
  end
  if dimension(length_unit) != dimension(u"m")
    throw(ErrorException("unit for length does not have proper dimension"))
  end
  if dimension(time_unit) != dimension(u"s")
    throw(ErrorException("unit for time does not have proper dimension"))
  end
  if dimension(energy_unit) != dimension(u"J")
    throw(ErrorException("unit for energy does not have proper dimension"))
  end
  if dimension(charge_unit) != dimension(u"C")
    throw(ErrorException("unit for charge does not have proper dimension"))
  end
  # record what units is currently being used
  global current_units = UnitSystem(mass_unit, length_unit, time_unit, energy_unit, charge_unit)

  # convert all the variables with dimension mass
  global m_electron = (__b_m_electron * u"eV/c^2" |> mass_unit).val         # Electron Mass 
  global m_proton = (__b_m_proton * u"eV/c^2" |> mass_unit).val             # Proton Mass 
  global m_neutron = (__b_m_neutron * u"eV/c^2" |> mass_unit).val           # Neutron Mass 
  global m_muon = (__b_m_muon * u"eV/c^2" |> mass_unit).val                 # Muon Mass 
  global m_helion = (__b_m_helion * u"eV/c^2" |> mass_unit).val             # Helion Mass He3 nucleus 
  global m_deuteron = (__b_m_deuteron * u"eV/c^2" |> mass_unit).val         # Deuteron Mass 
  global m_pion_0 = (__b_m_pion_0 * u"eV/c^2" |> mass_unit).val             # Pion 0 mass
  global m_pion_charged = (__b_m_pion_charged * u"eV/c^2" |> mass_unit).val # Pion+- Mass 

  # convert all the variables with dimension length
  global r_e = (__b_r_e * u"m" |> length_unit).val                     # classical electron radius

  # convert all the variables with dimension time

  # convert all the variables with dimension speed
  global c_light = (__b_c_light * u"m/s" |> length_unit / time_unit).val          # speed of light

  # convert all the variables with dimension energy

  # convert all the variables with dimension charge
  global e_charge = (__b_e_charge * u"C" |> charge_unit).val                                # elementary charge

  # constants with special dimenisions
  # convert Planck's constant with dimension energy * time
  global h_planck = (__b_h_planck * u"eV*s" |> energy_unit * time_unit).val        # Planck's constant 
  # convert Vacuum permeability with dimension force / (current)^2
  global mu_0_vac = __b_mu_0_vac
  # convert Vacuum permeability with dimension capacitance / distance
  global eps_0_vac = __b_eps_0_vac

  # convert anomous magnet moments dimension: unitless
  #global gyromagnetic_anomaly_electron = __b_gyromagnetic_anomaly_electron           # anomalous mag. mom. of the electron 
  #global gyromagnetic_anomaly_muon = __b_gyromagnetic_anomaly_muon               #        
  #global gyromagnetic_anomaly_proton = __b_gyromagnetic_anomaly_proton             # μ_p/μ_N - 1
  #global gyromagnetic_anomaly_deuteron = __b_gyromagnetic_anomaly_deuteron           # μ_{deuteron}/μ_N - 1
  #global gyromagnetic_anomaly_neutron = __b_gyromagnetic_anomaly_neutron            # μ_{neutron}/μ_N - 1
  #global gyromagnetic_anomaly_He3 = __b_gyromagnetic_anomaly_He3                # μ_{He3}/μ_N - 2

  # convert magnet moments dimension: energy / magnetic field strength
  global mu_deuteron = (__b_mu_deuteron * u"eV/T" |> energy_unit / u"T").val    # deuteron magnetic moment
  global mu_electron = (__b_mu_electron * u"eV/T" |> energy_unit / u"T").val    # electron magnetic moment
  global mu_helion = (__b_mu_helion * u"eV/T" |> energy_unit / u"T").val        # helion magnetic moment
  global mu_muon = (__b_mu_muon * u"eV/T" |> energy_unit / u"T").val            # muon magnetic moment
  global mu_neutron = (__b_mu_neutron * u"eV/T" |> energy_unit / u"T").val      # neutron magnetic moment
  global mu_proton = (__b_mu_proton * u"eV/T" |> energy_unit / u"T").val        # proton magnetic moment
  global mu_triton = (__b_mu_triton * u"eV/T" |> energy_unit / u"T").val        # triton magnetic moment

  # convert unitless variables
  global kg_per_amu = __b_kg_per_amu               # kg per standard atomic mass unit (dalton)
  global eV_per_amu = __b_eV_per_amu                  # eV per standard atomic mass unit (dalton)
  global N_avogadro = __b_N_avogadro                # Number / mole  (exact)
  global fine_structure = __b_fine_structure                 # fine structure constant

  # values calculated from other constants
  global classical_radius_factor = r_e * m_electron                 # e^2 / (4 pi eps_0) = classical_radius * mass * c^2. Is same for all particles of charge +/- 1.
  global r_p = r_e * m_electron / m_proton      # proton radius
  global h_bar_planck = h_planck / 2pi                   # h_planck/twopi
  global kg_per_eV = kg_per_amu / eV_per_amu
  global eps_0_vac = 1 / (c_light^2 * mu_0_vac)       # Permeability of free space
  if print_units
    printunits()
  end

  return
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

function massof(species::Species, unit::Union{Unitful.FreeUnits,AbstractString}=getunit(:mass))
  if unit isa AbstractString
    unit = uparse(unit)
  end
  if dimension(unit) != dimension(u"kg")
    throw(ErrorException("unit have proper dimension"))
  end
  return (species.mass * u"eV/c^2" |> unit).val
end

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

function chargeof(species::Species, unit::Union{Unitful.FreeUnits,AbstractString}=getunit(:charge))
  if unit isa AbstractString
    unit = uparse(unit)
  end
  if dimension(unit) != dimension(u"C")
    throw(ErrorException("unit have proper dimension"))
  end
  return (species.charge * u"e" |> unit).val
end

