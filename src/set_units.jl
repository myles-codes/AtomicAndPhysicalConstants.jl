using Unitful
include("physical_constants.jl")
include("species_initialize.jl")

# define units
module AtomicUnits
using Unitful
include("physical_constants.jl")
#@unit c "c" C_light (__b_c_light) * Unitful.m / Unitful.s false
#@unit eV "eV" Electric_volt (__b_e_charge) * Unitful.J false
@unit e "e" Elementary_charge __b_e_charge false
@unit amu "amu" Amu (1 / (__b_N_avogadro.val)) * u"g" false
end

Unitful.register(AtomicUnits);
using .AtomicUnits

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

"""
    function getunits(unit::Symbol)

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	  - 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                            -- type:Unitful.FreeUnits, default to the unit set from setunits(), the unit of the mass variable

"""
getunits

function getunits(unit::Symbol)
  if !@isdefined current_units
    throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
  else
    return getfield(current_units, unit)
  end
end

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
    function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS;
      mass_unit::Unitful.FreeUnits=unitsystem.mass,
      length_unit::Unitful.FreeUnits=unitsystem.length,
      time_unit::Unitful.FreeUnits=unitsystem.time,
      energy_unit::Unitful.FreeUnits=unitsystem.energy,
      charge_unit::Unitful.FreeUnits=unitsystem.charge,
    )

    ### Description:
    > return nothing<
    > users can specify the unit system and modify units in the system by keyword parameters<
    > sets global unit and store them in current units<
    > prints current units at the end<
    
    ### default units
    mass: eV/c^2
    length: m
    time: s
    energy: eV
    charge: elementary charge

    ### positional parameters:
    - 'unitsystem'                       -- type:UnitSystem, specify the unit system, default to PARTICLE_PHYSICS{mass:eV/c^2,charge:e}
                                        , it provides a convient way to set all the units

    ### keyword parameters
	  - `mass_unit`                        -- type:Unitful.FreeUnits, unit for mass, default to the mass unit in 'unitsystem'
	  - `length_unit`                      -- type:Unitful.FreeUnits, unit for length, default to the length unit in 'unitsystem'
    - `time_unit`                        -- type:Unitful.FreeUnits, unit for time, default to the time unit in 'unitsystem' 
    - `energy_unit`                      -- type:Unitful.FreeUnits, unit for energy, default to the energy unit in 'unitsystem'
    - `charge_unit`                      -- type:Unitful.FreeUnits, unit for charge, default to the charge unit in 'unitsystem'

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
  global m_electron = (__b_m_electron |> mass_unit).val         # Electron Mass 
  global m_proton = (__b_m_proton |> mass_unit).val             # Proton Mass 
  global m_neutron = (__b_m_neutron |> mass_unit).val           # Neutron Mass 
  global m_muon = (__b_m_muon |> mass_unit).val                 # Muon Mass 
  global m_helion = (__b_m_helion |> mass_unit).val             # Helion Mass He3 nucleus 
  global m_deuteron = (__b_m_deuteron |> mass_unit).val         # Deuteron Mass 
  global m_pion_0 = (__b_m_pion_0 |> mass_unit).val             # Pion 0 mass
  global m_pion_charged = (__b_m_pion_charged |> mass_unit).val # Pion+- Mass 

  # convert all the variables with dimension length
  global r_e = (__b_r_e |> length_unit).val                     # classical electron radius

  # convert all the variables with dimension time

  # convert all the variables with dimension speed
  global c_light = (__b_c_light |> length_unit / time_unit).val          # speed of light

  # convert all the variables with dimension energy

  # convert all the variables with dimension charge
  global e_charge = (__b_e_charge |> charge_unit).val                                # elementary charge

  # constants with special dimenisions
  # convert Planck's constant with dimension energy * time
  global h_planck = (__b_h_planck |> energy_unit * time_unit).val        # Planck's constant 
  # convert Vacuum permeability with dimension force / (current)^2
  global mu_0_vac = __b_mu_0_vac.val
  # convert Vacuum permeability with dimension capacitance / distance
  global eps_0_vac = __b_eps_0_vac.val

  # convert anomous magnet moments dimension: unitless
  #global gyromagnetic_anomaly_electron = __b_gyromagnetic_anomaly_electron           # anomalous mag. mom. of the electron 
  #global gyromagnetic_anomaly_muon = __b_gyromagnetic_anomaly_muon               #        
  #global gyromagnetic_anomaly_proton = __b_gyromagnetic_anomaly_proton             # μ_p/μ_N - 1
  #global gyromagnetic_anomaly_deuteron = __b_gyromagnetic_anomaly_deuteron           # μ_{deuteron}/μ_N - 1
  #global gyromagnetic_anomaly_neutron = __b_gyromagnetic_anomaly_neutron            # μ_{neutron}/μ_N - 1
  #global gyromagnetic_anomaly_He3 = __b_gyromagnetic_anomaly_He3                # μ_{He3}/μ_N - 2

  # convert magnet moments dimension: energy / magnetic field strength
  global mu_deuteron = (__b_mu_deuteron |> energy_unit / u"T").val    # deuteron magnetic moment
  global mu_electron = (__b_mu_electron |> energy_unit / u"T").val    # electron magnetic moment
  global mu_helion = (__b_mu_helion |> energy_unit / u"T").val        # helion magnetic moment
  global mu_muon = (__b_mu_muon |> energy_unit / u"T").val            # muon magnetic moment
  global mu_neutron = (__b_mu_neutron |> energy_unit / u"T").val      # neutron magnetic moment
  global mu_proton = (__b_mu_proton |> energy_unit / u"T").val        # proton magnetic moment
  global mu_triton = (__b_mu_triton |> energy_unit / u"T").val        # triton magnetic moment

  # convert unitless variables
  global kg_per_amu = __b_kg_per_amu               # kg per standard atomic mass unit (dalton)
  global eV_per_amu = __b_eV_per_amu                  # eV per standard atomic mass unit (dalton)
  global N_avogadro = __b_N_avogadro.val                   # Number / mole  (exact)
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
    function massof(particle::Species, unit::Unitful.FreeUnits=current_units.mass)

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	  - 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                            -- type:Unitful.FreeUnits, default to the unit set from setunits(), the unit of the mass variable

"""
massof

function massof(particle::Species, unit::Unitful.FreeUnits=getunits(:mass))
  return (particle.mass * u"eV/c^2" |> unit).val
end

"""
    function chargeof(particle::Species, unit::Unitful.FreeUnits=current_units.charge)

    ### Description:
    > return charge of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                  -- type:particle, the particle whose charge you want to know
  - `unit`                      -- type:Unitful.FreeUnits, default to the unit set from setunits(), the unit of the charge variable

"""
chargeof

function chargeof(particle::Species, unit::Unitful.FreeUnits=getunits(:charge))
  return (particle.charge * u"e" |> unit).val
end

export setunits, printunits
export massof, chargeof
export c_light, m_electron, m_proton, m_neutron, m_muon, m_helion, m_deuteron, m_pion_0, m_pion_charged
export r_e, e_charge, h_planck, mu_0_vac, eps_0_vac
export kg_per_amu, eV_per_amu, N_avogadro, fine_structure, classical_radius_factor, r_p, h_bar_planck, kg_per_eV, eps_0_vac
export mu_deuteron, mu_electron, mu_helion, mu_muon, mu_neutron, mu_proton, mu_triton
#export anom_mag_moment_electron, anom_mag_moment_muon, anom_mag_moment_proton, anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3
