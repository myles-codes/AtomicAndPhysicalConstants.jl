
include("PhysicalConstants.jl")
include("ParticleTypes.jl")
"""
    Unit

    ### Description:
    > abstract type for storing units <

"""
Unit

abstract type Unit end

# overriding how Units are printed

Base.print(io::IO, unit::T) where {T<:Unit} = print(io, " \"", unit.name, "\" \t\t where ", unit.conversion, " ", unit.name, "\t = 1 ")

"""
    scale

    ### Description:
    > return scaled units that has prefix 'prefix' and is scaled by 'factor' <

"""
scale

function scale(unit::T, prefix::AbstractString, factor::Float64) where {T<:Unit}
    return T(prefix * unit.name, unit.conversion / factor)
end

"""
    Mass<:Unit

    ### Description:
    > immutable struct for storing mass units<
    > the basis for conversion is amu<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 amu

"""
Mass

struct Mass <: Unit
    name::AbstractString
    conversion::Float64
end


"""
    Length<:Unit

    ### Description:
    > immutable struct for storing length units<
    > the basis for conversion is meter<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 meter

"""
Length

struct Length <: Unit
    name::AbstractString
    conversion::Float64
end

"""
    Time_<:Unit

    ### Description:
    > immutable struct to be used for storing time units<
    > the basis for conversion is second<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 second

"""
Time_

struct Time_ <: Unit
    name::AbstractString
    conversion::Float64
end

"""
    Speed<:Unit

    ### Description:
    > immutable struct to be used for storing speed units<
    > the basis for conversion is meter per second<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 meter per second

"""
Speed

struct Speed <: Unit
    name::AbstractString
    conversion::Float64
end

# Define devision operation that makes Speed from Length / Time 
Base.:/(a::Length, b::Time_) = Speed(a.name * "/" * b.name, a.conversion / b.conversion)

"""
    Energy<:Unit

    ### Description:
    > immutable struct to be used for storing energy units<
    > the basis for conversion is electric volts<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 eV

"""
Energy

struct Energy <: Unit
    name::AbstractString
    conversion::Float64
end

"""
    Charge<:Unit

    ### Description:
    > immutable struct to be used for storing charge units<
    > the basis for conversion is elementary charge<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 e

"""
Charge

struct Charge <: Unit
    name::AbstractString
    conversion::Float64
end


"""
    printunits

    ### Description:
    > return nothing<
    > prints the units for each dimensions<
    > prints the units of constants with speical dimenisions<
 
"""
printunits

function printunits()
    if !@isdefined current_units
        throw(ErrorException("units are not set, call setunits() to initalize units and constants"))
    end
    # prints the units for each dimensions
    println("mass:\t", current_units.mass, "amu")
    println("length:\t", current_units.length, "m")
    println("time:\t", current_units.time, "s")
    println("speed:\t", current_units.speed, "m/s")
    println("energy:\t", current_units.energy, "eV")
    println("charge:\t", current_units.charge, "e")
    return
end

"""
    prefix

    ### Description:
    > dictionary that store how scaling factors relate to prefixs<

"""
prefix

prefix::Dict{AbstractString,Float64} = Dict(
    "k" => 10^3,
    "M" => 10^6,
    "G" => 10^9,
    "T" => 10^12,
    "m" => 10^-3,
    "u" => 10^-6,
    "n" => 10^9,
    "p" => 10^-12,
    "f" => 10^-15,
    "a" => 10^-18
)

UNIT::Dict{AbstractString,Unit} = Dict(
    "amu" => Mass("amu", 1.0),
    "eV/c^2" => Mass("eV/c^2", __b_eV_per_amu),
    "g" => Mass("g", __b_kg_per_amu * 10^3),
    "kg" => Mass("kg", __b_kg_per_amu),
    "C" => Charge("C", __b_e_charge),
    "e" => Charge("e", 1.0),
    "m" => Length("m", 1.0),
    "cm" => Length("cm", 100.0),
    "A" => Length("Å", 10^10),
    "s" => Time_("s", 1.0),
    "minute" => Time_("minute", 1 / 60),
    "hour" => Time_("hour", 1 / 3600),
    "c" => Speed("c", 1 / __b_c_light),
    "m/s" => Speed("m/s", 1.0),
    "cm/s" => Speed("cm/s", 100.0),
    "J" => Energy("J", __b_e_charge),
    "eV" => Energy("eV", 1.0)
)

"""
    tounit

    ### Description:
    > return the correponding unit for the given symbol<

    ### parameters:
	- `unit`                        -- type: Symbol, name of the unit


"""
tounit

function tounit(unit::Symbol)
    name = string(unit)
    if haskey(UNIT, name)
        return scale(UNIT[name], key, value)
    end
    for (key, value) in prefix
        if startswith(name, key)
            name_without_prefix = name[length(key)+1:end]
            if haskey(UNIT, name_without_prefix)
                return scale(UNIT[name_without_prefix], key, value)
            end
        end
    end
    throw(ArgumentError("unit \"" * name * "\" does not exist"))
end

"""
    UnitSystem

    ### Description:
    > immutable struct for storing unit systems<

    ### Fields:
	- `mass`                    -- type:Mass, stores the unit for mass
	- `length`                  -- type:Length, stores the unit for length
    - `time`                    -- type:Time, stores the unit for time

    ### Note:
    'speed' is compute from 'length'/'time' so it is not included in the unitsystem

"""
UnitSystem

struct UnitSystem
    mass::Mass
    length::Length
    time::Time_
    speed::Speed
    energy::Energy
    charge::Charge
end

PARTICLE_PHYSICS = UnitSystem(UNIT["eV/c^2"], UNIT["m"], UNIT["s"], UNIT["m/s"], UNIT["eV"], UNIT["e"])
MKS = UnitSystem(UNIT["kg"], UNIT["m"], UNIT["s"], UNIT["m/s"], UNIT["J"], UNIT["C"])
CGS = UnitSystem(UNIT["g"], UNIT["cm"], UNIT["s"], UNIT["cm/s"], UNIT["J"], UNIT["C"])

"""
    current_units :: UnitSystem

    ### Description:
    > a UnitSystem that stores currently using units<

    ### Note:
    it is initialized when setunits() is called

"""
current_units


"""
    function setunits(unitsystem::Symbol=:default;
        mass::Symbol=:default,
        charge::Symbol=:default,
    )

    ### Description:
    > return nothing<
    > users can specify the unit system and modify units in the system by keyword parameters<
    > sets global unit and store them in current units<
    
    ### default units
    mass: eV/c^2
    length: m
    time: s
    speed: m/s
    energy: eV
    charge: elementary charge

    ### positional parameters:
    - 'unitsystem'                  -- type:Symbol, specify the unit system, default to PARTICLE_PHYSICS{mass:eV/c^2,charge:e}
                                        , it provides a convient way to set all the units

    ### keyword parameters:
	- `mass`                        -- type:Symbol, unit for mass, default to the mass unit in 'unitsystem'
	- `length`                      -- type:Symbol, unit for length, default to the length unit in 'unitsystem'
    - `time`                        -- type:Symbol, unit for time, default to the time unit in 'unitsystem'
    - `speed`                       -- type:Symbol, unit for speed, default to the length unit in 'unitsystem'/time unit in 'unitsystem'. speed is also default to 'length'/'time' unit unless specified. 
    - `energy`                      -- type:Symbol, unit for energy, default to the energy unit in 'unitsystem'
    - `charge`                      -- type:Symbol, unit for charge, default to the charge unit in 'unitsystem'

    ### Note:
    - unit for Plancks' constant is 'energy' * 'time'
    - unit for vacuum permeability is N/A^2
    - unit for Permittivity of free space is F/m
    - unit for Avogadro's number is mol^-1
    - unit for classical radius factor is 'length'*'mass'

"""
setunits

function setunits(unitsystem::Symbol=:default;
    mass::Symbol=:default,
    length::Symbol=:default,
    time::Symbol=:default,
    speed::Symbol=:default,
    energy::Symbol=:default,
    charge::Symbol=:default,
)
    #stores unitsystem as a struct
    unit_system = PARTICLE_PHYSICS
    if unitsystem == :MKS
        unit_system = MKS
    elseif unitsystem == :CGS
        unit_system = CGS
    elseif unitsystem == :ParticlePhysics || unitsystem == :default || unitsystem == :P
        unit_system = PARTICLE_PHYSICS
    else
        throw(ArgumentError("unit system \"" * string(unitsystem) * "\" does not exist"))
    end

    # get Unit struct from Symbol
    mass_unit::Mass = unit_system.mass
    if mass == :default
        mass_unit = unit_system.mass
    else
        mass_unit = tounit(mass)
    end

    length_unit::Length = unit_system.length
    if length == :default
        length_unit = unit_system.length
    else
        length_unit = tounit(length)
    end

    time_unit::Time_ = unit_system.time
    if time == :default
        time_unit = unit_system.time
    else
        time_unit = tounit(time)
    end

    speed_unit::Speed = unit_system.speed
    if speed == :default
        speed_unit = length_unit / time_unit
    else
        speed_unit = tounit(speed)
    end

    energy_unit::Energy = unit_system.energy
    if energy == :default
        energy_unit = unit_system.energy
    else
        energy_unit = tounit(energy)
    end

    charge_unit::Charge = unit_system.charge
    if charge == :default
        charge_unit = unit_system.charge
    else
        charge_unit = tounit(charge)
    end

    # record what units is currently being used
    global current_units = UnitSystem(mass_unit, length_unit, time_unit, speed_unit, energy_unit, charge_unit)

    # convert all the variables with dimension mass
    global m_electron = mass_unit.conversion * __b_m_electron / __b_eV_per_amu       # Electron Mass 
    global m_proton = mass_unit.conversion * __b_m_proton / __b_eV_per_amu           # Proton Mass 
    global m_neutron = mass_unit.conversion * __b_m_neutron / __b_eV_per_amu         # Neutron Mass 
    global m_muon = mass_unit.conversion * __b_m_muon / __b_eV_per_amu              # Muon Mass 
    global m_helion = mass_unit.conversion * __b_m_helion / __b_eV_per_amu           # Helion Mass He3 nucleus 
    global m_deuteron = mass_unit.conversion * __b_m_deuteron / __b_eV_per_amu       # Deuteron Mass 
    global m_pion_0 = mass_unit.conversion * __b_m_pion_0 / __b_eV_per_amu           # Pion 0 Mass                              
    global m_pion_charged = mass_unit.conversion * __b_m_pion_charged / __b_eV_per_amu   # Pion+- Mass

    # convert all the variables with dimension length
    global r_e = length_unit.conversion * __b_r_e                                    # classical electron radius

    # convert all the variables with dimension time

    # convert all the variables with dimension speed
    global c_light = speed_unit.conversion * __b_c_light                             # speed of light

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
    global anom_mag_moment_electron = __b_anom_mag_moment_electron           # anomalous mag. mom. of the electron 
    global anom_mag_moment_muon = __b_anom_mag_moment_muon               #        
    global anom_mag_moment_proton = __b_anom_mag_moment_proton             # μ_p/μ_N - 1
    global anom_mag_moment_deuteron = __b_anom_mag_moment_deuteron           # μ_{deuteron}/μ_N - 1
    global anom_mag_moment_neutron = __b_anom_mag_moment_neutron            # μ_{neutron}/μ_N - 1
    global anom_mag_moment_He3 = __b_anom_mag_moment_He3                # μ_{He3}/μ_N - 2

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
    return
end

"""
    massof

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                            -- type:Symbol, default to the unit set from setunits(), the unit of the mass variable

"""
massof

function massof(particle::Particle, unit::Symbol=:default)
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
    chargeof

    ### Description:
    > return charge of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                        -- type:particle, the particle whose charge you want to know
    - `unit`                      -- type:Symbol, default to the unit set from setunits(), the unit of the charge variable

"""
chargeof

function chargeof(particle::Particle, unit::Symbol=:default)
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
export c_light, m_electron, m_proton, m_neutron, m_muon, m_helion, m_deuteron, m_pion_0, m_pion_charged
export r_e, e_charge, h_planck, mu_0_vac, eps_0_vac
export anom_mag_moment_electron, anom_mag_moment_muon, anom_mag_moment_proton, anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3
export kg_per_amu, eV_per_amu, N_avogadro, fine_structure, classical_radius_factor, r_p, h_bar_planck, kg_per_eV, eps_0_vac