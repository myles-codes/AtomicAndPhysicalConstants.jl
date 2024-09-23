using Unitful
include("PhysicalConstants.jl")
include("ParticleTypes.jl")
include("AtomicUnits.jl")
Unitful.register(AtomicUnits);
using .AtomicUnits

# global constants with units
# symbol input or unit input? unit input has more freedom and more interpretable but more difficult from users
# keep unit inside and vals outside?
# define our own units?

b_m_electron = __b_m_electron * u"eV/c^2"


"""
    UnitSystem

    ### Description:
    > immutable struct for storing unit systems<

    ### Fields:
	- `mass`                    -- type:Mass, stores the unit for mass
	- `length`                  -- type:Length, stores the unit for length
  - `time`                    -- type:Time, stores the unit for time
  - `energy`                  -- type:Energy, stores the unit for energy
  - `charge`                  -- type:Charge, stores the unit for charge


"""
UnitSystem

struct UnitSystem
  mass::Unitful.FreeUnits
  length::Unitful.FreeUnits
  time::Unitful.FreeUnits
  energy::Unitful.FreeUnits
  charge::Unitful.FreeUnits
end

PARTICLE_PHYSICS = UnitSystem(u"eV/c^2", u"m", u"s", u"eV", u"e")
MKS = UnitSystem(u"kg", u"m", u"s", u"J", u"C")
CGS = UnitSystem(u"g", u"cm", u"s", u"J", u"C")

"""
    current_units :: UnitSystem

    ### Description:
    > a UnitSystem that stores currently using units<

    ### Note:
    it is initialized when setunits() is called

"""
current_units

function printunits()
  if !@isdefined current_units
    throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
  end
  # prints the units for each dimensions
  println("mass:\t", current_units.mass)
  println("length:\t", current_units.length)
  println("time:\t", current_units.time)
  println("energy:\t", current_units.energy)
  println("charge:\t", current_units.charge)
  return
end


"""
    function setunits(unitsystem::Union{Symbol,Expr}=:default;
        mass::Union{Symbol,Expr}=:default,
        length::Union{Symbol,Expr}=:default,
        time::Union{Symbol,Expr}Symbol=:default,
        energy::Union{Symbol,Expr}=:default,
        charge::Union{Symbol,Expr}=:default,
    )

    ### Description:
    > return nothing<
    > users can specify the unit system and modify units in the system by keyword parameters<
    > sets global unit and store them in current units<
    
    ### default units
    mass: eV/c^2
    length: m
    time: s
    energy: eV
    charge: elementary charge

    ### positional parameters:
    - 'unitsystem'                  -- type:Symbol or Expr, specify the unit system, default to PARTICLE_PHYSICS{mass:eV/c^2,charge:e}
                                        , it provides a convient way to set all the units

    ### keyword parameters
	- `mass`                        -- type:Symbol or Expr, unit for mass, default to the mass unit in 'unitsystem'
	- `length`                      -- type:Symbol or Expr, unit for length, default to the length unit in 'unitsystem'
    - `time`                        -- type:Symbol or Expr, unit for time, default to the time unit in 'unitsystem' 
    - `energy`                      -- type:Symbol or Expr, unit for energy, default to the energy unit in 'unitsystem'
    - `charge`                      -- type:Symbol or Expr, unit for charge, default to the charge unit in 'unitsystem'

    ### Note:
    - unit for Plancks' constant is 'energy' * 'time'
    - unit for vacuum permeability is N/A^2
    - unit for Permittivity of free space is F/m
    - unit for Avogadro's number is mol^-1
    - unit for classical radius factor is 'length'*'mass'

"""
setunits

function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS;
  mass_unit::Unitful.FreeUnits=unitsystem.mass,
  length_unit::Unitful.FreeUnits=unitsystem.length,
  time_unit::Unitful.FreeUnits=unitsystem.time,
  energy_unit::Unitful.FreeUnits=unitsystem.energy,
  charge_unit::Unitful.FreeUnits=unitsystem.charge,
)
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
  # convert the units
  global m_electron = (b_m_electron |> mass_unit).val

  printunits()

  return
end

"""
    function massof(particle::Particle, unit::Union{Symbol,Expr}=:default)

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	  - 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                            -- type:Symbol or Expr, default to the unit set from setunits(), the unit of the mass variable

"""
massof

function massof(particle::Particle, unit::Union{Symbol,Expr}=:default)
  if (unit == :default)
    if !@isdefined current_units
      throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
    else
      return particle.mass * current_units.mass.conversion
    end
  else
    mass::Mass = tounit(unit)
    return particle.mass * mass.conversion
  end
end

"""
    function chargeof(particle::Particle, unit::Union{Symbol,Expr}=:default)

    ### Description:
    > return charge of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                  -- type:particle, the particle whose charge you want to know
    - `unit`                      -- type:Symbol or Expr, default to the unit set from setunits(), the unit of the charge variable

"""
chargeof

function chargeof(particle::Particle, unit::Union{Symbol,Expr}=:default)
  if (unit == :default)
    if !@isdefined current_units
      throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
    else
      return particle.charge * current_units.charge.conversion
    end
  else
    charge::Charge = tounit(unit)
    return particle.charge * charge.conversion
  end
end

export setunits, printunits
export massof, chargeof
export m_electron