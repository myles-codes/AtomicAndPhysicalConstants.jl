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

  # convert all the variables with dimension mass
  global m_electron = mass_unit.conversion * __b_m_electron        # Electron Mass 
  global m_proton = mass_unit.conversion * __b_m_proton            # Proton Mass 
  global m_neutron = mass_unit.conversion * __b_m_neutron          # Neutron Mass 
  global m_muon = mass_unit.conversion * __b_m_muon               # Muon Mass 
  global m_helion = mass_unit.conversion * __b_m_helion            # Helion Mass He3 nucleus 
  global m_deuteron = mass_unit.conversion * __b_m_deuteron        # Deuteron Mass 
  global m_pion_0 = mass_unit.conversion * __b_m_pion_0            # Pion 0 Mass                              
  global m_pion_charged = mass_unit.conversion * __b_m_pion_charged    # Pion+- Mass

  # convert all the variables with dimension length
  global r_e = length_unit.conversion * __b_r_e                                    # classical electron radius

  # convert all the variables with dimension time

  # convert all the variables with dimension speed
  global c_light = __b_c_light * length_unit.conversion / time_unit.conversion      # speed of light

  # convert all the variables with dimension energy

  # convert all the variables with dimension charge
  global e_charge = 1 * charge_unit.conversion                                     # elementary charge

  # constants with special dimenisions
  # convert Planck's constant with dimension energy * time
  global h_planck = __b_h_planck * energy_unit.conversion * time_unit.conversion        # Planck's constant 
  # convert Vacuum permeability with dimension force / (current)^2
  global mu_0_vac = __b_mu_0_vac
  # convert Vacuum permeability with dimension capacitance / distance
  global eps_0_vac = __b_eps_0_vac

  # convert anomous magnet moments dimension: unitless
  global gyromagnetic_anomaly_electron = __b_gyromagnetic_anomaly_electron           # anomalous mag. mom. of the electron 
  global gyromagnetic_anomaly_muon = __b_gyromagnetic_anomaly_muon               #        
  global gyromagnetic_anomaly_proton = __b_gyromagnetic_anomaly_proton             # μ_p/μ_N - 1
  global gyromagnetic_anomaly_deuteron = __b_gyromagnetic_anomaly_deuteron           # μ_{deuteron}/μ_N - 1
  global gyromagnetic_anomaly_neutron = __b_gyromagnetic_anomaly_neutron            # μ_{neutron}/μ_N - 1
  global gyromagnetic_anomaly_He3 = __b_gyromagnetic_anomaly_He3                # μ_{He3}/μ_N - 2

  # convert unitless variables
  global kg_per_amu = __b_kg_per_amu               # kg per standard atomic mass unit (dalton)
  global eV_per_amu = __b_eV_per_amu                  # eV per standard atomic mass unit (dalton)
  global N_avogadro = __b_N_avogadro                   # Number / mole  (exact)
  global fine_structure = __b_fine_structure                 # fine structure constant

  # values calculated from other constants
  global classical_radius_factor = r_e * m_electron                 # e^2 / (4 pi eps_0) = classical_radius * mass * c^2. Is same for all particles of charge +/- 1.
  global r_p = r_e * m_electron / m_proton      # proton radius
  global h_bar_planck = h_planck / 2pi                   # h_planck/twopi
  global kg_per_eV = kg_per_amu / eV_per_amu
  global eps_0_vac = 1 / (c_light^2 * mu_0_vac)       # Permeability of free space
  printunits()

  return
end

"""
    function massof(particle::Species, unit::Union{Symbol,Expr}=:default)

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	  - 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                            -- type:Symbol or Expr, default to the unit set from setunits(), the unit of the mass variable

"""
massof

function massof(particle::Species, unit::Union{Symbol,Expr}=:default)
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

function chargeof(particle::Species, unit::Union{Symbol,Expr}=:default)
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