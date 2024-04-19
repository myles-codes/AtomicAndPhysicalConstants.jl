include("PhysicalConstants.jl")
include("Global.jl")

"""
    Unit

    ### Description:
    > abstract type for storing units <

""" Unit

abstract type Unit end

# overriding how Units are printed

Base.print(io::IO, unit::T) where T<: Unit = print(io, " \"",unit.name,"\" \t\t where ",unit.conversion," ",unit.name,"\t = 1 ")


# scaling functions that turns unit to kilo-unit, mega-unit, etc

"""
    kilo

    ### Description:
    > takes in a Unit 'unit' and return kilo-'unit' <
    > puts a k in its name and make unit.conversion into unit.conversion/10^3

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" kilo

function kilo(unit::T) where T <: Unit
    return T("k"*unit.name,unit.conversion/10^3)
end

"""
    mega

    ### Description:
    > takes in a Unit 'unit' and return mega-'unit' <
    > puts a M in its name and make unit.conversion into unit.conversion/10^6

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" mega

function mega(unit::T) where T <: Unit
    return T("M"*unit.name,unit.conversion/10^6)
end

"""
    giga

    ### Description:
    > takes in a Unit 'unit' and return giga-'unit' <
    > puts a G in its name and make unit.conversion into unit.conversion/10^9

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" giga

function giga(unit::T) where T <: Unit
    return T("G"*unit.name,unit.conversion/10^9)
end

"""
    tera

    ### Description:
    > takes in a Unit 'unit' and return tera-'unit' <
    > puts a T in its name and make unit.conversion into unit.conversion/10^12

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" tera

function tera(unit::U) where U <: Unit
    return U("T"*unit.name,unit.conversion/10^12)
end

"""
    mili

    ### Description:
    > takes in a Unit 'unit' and return mili-'unit' <
    > puts a m in its name and make unit.conversion into unit.conversion/10^-3

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" mili

function mili(unit::T) where T <: Unit
    return T("m"*unit.name,unit.conversion/10^-3)
end

"""
    micro

    ### Description:
    > takes in a Unit 'unit' and return micro-'unit' <
    > puts a mu- in its name and make unit.conversion into unit.conversion/10^-6

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" micro

function micro(unit::T) where T <: Unit
    return T("mu-"*unit.name,unit.conversion/10^-6)
end

"""
    nano

    ### Description:
    > takes in a Unit 'unit' and return nano-'unit' <
    > puts a n in its name and make unit.conversion into unit.conversion/10^-9

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" nano

function nano(unit::T) where T <: Unit
    return T("n"*unit.name,unit.conversion/10^-9)
end

"""
    pico

    ### Description:
    > takes in a Unit 'unit' and return pico-'unit' <
    > puts a p in its name and make unit.conversion into unit.conversion/10^-12

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" pico

function pico(unit::T) where T <: Unit
    return T("p"*unit.name,unit.conversion/10^-12)
end

"""
    Mass<:Unit

    ### Description:
    > immutable struct for storing mass units<
    > the basis for conversion is amu<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 amu

""" Mass

struct Mass<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    MASS
    ### Description:
    > a name tuple for storing all the units for mass<
    > units includes: amu, eV/c^2, keV/c^2, MeV/c^2, GeV/c^2, kg, g, mg<

    ### Example:
    MASS.amu is the unit 'amu', it refers the the struct Mass("amu",1.0)

""" MASS

MASS = (amu = Mass("amu",1.0), 
    eV = Mass("eV/c^2",__b_eV_per_amu),
    kg = Mass("kg",__b_kg_per_amu), 
    g = Mass("g",__b_kg_per_amu*10^3))


"""
    Length<:Unit

    ### Description:
    > immutable struct for storing length units<
    > the basis for conversion is meter<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 meter

""" Length

struct Length<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    LENGTH
    ### Description:
    > a name tuple for storing all the units for length<
    > units includes: m, cm, mm, km<

    ### Example:
    LENGTH.m is the unit 'meter', it refers the the struct Length("m",1.0)

""" LENGTH

LENGTH = (m = Length("m",1.0), 
    cm = Length("cm",100.0),
    A = Length("Å",10^10))

"""
    Time_<:Unit

    ### Description:
    > immutable struct to be used for storing time units<
    > the basis for conversion is second<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 second

""" Time_

struct Time_<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    TIME
    ### Description:
    > a name tuple for storing all the units for time<
    > units includes: s, minute, hour<

    ### Example:
    TIME.s is the unit 'second', it refers the the struct Length("s",1.0)

""" TIME

TIME = (s = Time_("s",1.0),
    minute = Time_("minute",1/60),
    hour = Time_("hour",1/3600),)

"""
    Speed<:Unit

    ### Description:
    > immutable struct to be used for storing speed units<
    > the basis for conversion is meter per second<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 meter per second

""" Speed

struct Speed<:Unit
    name::AbstractString
    conversion::Float64
end

# Define devision operation that makes Speed from Length / Time 
Base.:/(a::Length, b::Time_) = Speed(a.name*"/"*b.name,a.conversion/b.conversion)

"""
    Speed
    ### Description:
    > a name tuple for storing all the units for speed<
    > units includes: c, m/s<

""" SPEED

SPEED = (c = Speed("c",1/__b_c_light), m_per_s = LENGTH.m/TIME.s)

"""
    Energy<:Unit

    ### Description:
    > immutable struct to be used for storing energy units<
    > the basis for conversion is electric volts<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 eV

""" Energy

struct Energy<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    ENERGY
    ### Description:
    > a named tuple for storing all the units for ENERGY<
    > units includes: J, eV<

""" ENERGY

ENERGY = (J = Energy("J", __b_e_charge),
    eV = Energy("eV",1.0))

"""
    Charge<:Unit

    ### Description:
    > immutable struct to be used for storing charge units<
    > the basis for conversion is elementary charge<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 e

""" Charge

struct Charge<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    CHARGE
    ### Description:
    > a named tuple for storing all the units for CHARGE<
    > units includes:C, e<

""" CHARGE

CHARGE = (C = Charge("C", __b_e_charge),
    e = Charge("e",1.0))
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

""" UnitSystem

struct UnitSystem
    mass::Mass
    length::Length
    time::Time_
    energy::Energy
    charge::Charge
end

PARTICLE_PHYSICS = UnitSystem(MASS.amu,LENGTH.m,TIME.s,ENERGY.eV,CHARGE.e)
MKS = UnitSystem(MASS.kg,LENGTH.m,TIME.s,ENERGY.J,CHARGE.C)
CGS = UnitSystem(MASS.g,LENGTH.cm,TIME.s,ENERGY.J,CHARGE.C)

"""
    current_units

    ### Description:
    > an array of type Unit that stores currently using units<

    ### Note:
    it is initialized when setunits() is called

""" current_units

current_units = Unit[]

"""
    printunits

    ### Description:
    > return nothing<
    > prints the units for each dimensions<
    > prints the units of constants with speical dimenisions<
 
""" printunits

function printunits()
    if isempty(current_units) 
        println("units are not set, call setunits() to initalize units and constants")
        return 
    end
    # prints the units for each dimensions
    println("mass:\t",current_units[1],"amu")
    println("length:\t",current_units[2],"m")
    println("time:\t",current_units[3],"s")
    println("speed:\t",current_units[4],"m/s")
    println("energy:\t",current_units[5],"eV")
    println("charge:\t",current_units[6],"e")

    # prints the units of constants with speical dimenisions
    println("h_planck:\t",current_units[5].name*"*"*current_units[3].name)
    println("h_bar_planck:\t",current_units[5].name*"*"*current_units[3].name)
    println("mu_0_vac:\t","N/A^2")
    println("eps_0_vac:\t","F/m")
    println("N_avogadro:\t","mol^-1")
    println("classical_radius_factor:\t",current_units[2].name*"*"*current_units[1].name)
    return
end

"""
    setunits

    ### Description:
    > return nothing<
    > set global non constants to the value in units specified<
    > users can specify the unit system and modify units in the system by keyword parameters<
    
    ### default units
    mass: amu
    length: m
    time: s

    ### positional parameters:
    - 'unitsystem'                  -- type:UnitSystem, specify the unit system, default to PARTICLE_PHYSICS, it provides a convient way to set all the units

    ### keyword parameters:
	- `mass`                        -- type:Mass, unit for mass, default to the mass unit in 'unitsystem'
	- `length`                      -- type:Length, unit for length, default to the length unit in 'unitsystem'
    - `time`                        -- type:Time, unit for time, default to the time unit in 'unitsystem'
    - `speed`                       -- type:Speed, unit for speed, default to the length unit in 'unitsystem'/time unit in 'unitsystem'. speed is also default to 'length'/'time' unit unless specified. 
    - `energy`                      -- type:Energy, unit for energy, default to the energy unit in 'unitsystem'

    ### Note:
    - unit for Plancks' constant is 'energy' * 'time'
    - unit for vacuum permeability is N/A^2
    - unit for Avogadro's number is mol^-1
    - unit for classical radius factor is 'length'*'mass'

""" setunits

function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS; 
    mass::Mass = unitsystem.mass, 
    length::Length = unitsystem.length,
    time::Time_ = unitsystem.time,
    speed::Speed = length/time,
    energy::Energy  = unitsystem.energy,
    charge::Charge  = unitsystem.charge
    )
    # record what units is currently being used
    empty!(current_units)
    push!(current_units,mass)
    push!(current_units,length)
    push!(current_units,time)
    push!(current_units,speed)
    push!(current_units,energy)
    push!(current_units,charge)
    
    # convert all the variables with dimension mass
    global m_electron = mass.conversion * __b_m_electron / __b_eV_per_amu       # Electron Mass 
    global m_proton = mass.conversion * __b_m_proton / __b_eV_per_amu           # Proton Mass 
    global m_neutron = mass.conversion * __b_m_neutron / __b_eV_per_amu         # Neutron Mass 
    global m_muon = mass.conversion * __b_m_muon  / __b_eV_per_amu              # Muon Mass 
    global m_helion = mass.conversion * __b_m_helion / __b_eV_per_amu           # Helion Mass He3 nucleus 
    global m_deuteron = mass.conversion * __b_m_deuteron / __b_eV_per_amu       # Deuteron Mass 
    global m_pion_0 = mass.conversion * __b_m_pion_0 / __b_eV_per_amu           # Pion 0 Mass                              
    global m_pion_charged = mass.conversion * __b_m_pion_charged / __b_eV_per_amu   # Pion+- Mass

    # convert all the variables with dimension length
    global r_e = length.conversion * __b_r_e                                    # classical electron radius

    # convert all the variables with dimension time

    # convert all the variables with dimension speed
    global c_light = speed.conversion * __b_c_light                             # speed of light

    # convert all the variables with dimension energy

    # convert all the variables with dimension charge
    global e_charge = 1 * charge.conversion                                     # elementary charge

    # constants with special dimenisions
    # convert Planck's constant with dimension energy * time
    global h_planck = __b_h_planck * energy.conversion * time.conversion        # Planck's constant 
    # convert Vacuum permeability with dimension force / (current)^2
    global mu_0_vac = __b_mu_0_vac

    # convert anomous magnet moments dimension: unitless
    global anom_mag_moment_electron    = __b_anom_mag_moment_electron           # anomalous mag. mom. of the electron 
    global anom_mag_moment_muon        = __b_anom_mag_moment_muon               #        
    global anom_mag_moment_proton      = __b_anom_mag_moment_proton             # μ_p/μ_N - 1
    global anom_mag_moment_deuteron    = __b_anom_mag_moment_deuteron           # μ_{deuteron}/μ_N - 1
    global anom_mag_moment_neutron     = __b_anom_mag_moment_neutron            # μ_{neutron}/μ_N - 1
    global anom_mag_moment_He3         = __b_anom_mag_moment_He3                # μ_{He3}/μ_N - 2

    # convert unitless variables
    global kg_per_amu                 = __b_kg_per_amu               # kg per standard atomic mass unit (dalton)
    global eV_per_amu                 = __b_eV_per_amu                  # eV per standard atomic mass unit (dalton)
    global N_avogadro                 = __b_N_avogadro                   # Number / mole  (exact)
    global fine_structure             = __b_fine_structure                 # fine structure constant

    # values calculated from other constants
    global classical_radius_factor = r_e * m_electron                 # e^2 / (4 pi eps_0) = classical_radius * mass * c^2. Is same for all particles of charge +/- 1.
    global r_p                     = r_e * m_electron / m_proton      # proton radius
    global h_bar_planck            = h_planck / 2pi                   # h_planck/twopi
    global kg_per_eV               = kg_per_amu / eV_per_amu
    global eps_0_vac               = 1 / (c_light^2 * mu_0_vac)       # Permeability of free space
    printunits()
    return
end

export setunits, printunits
export Unit, Mass, Length, Time_, Speed, Energy, Charge
export MASS,LENGTH,TIME,SPEED,ENERGY,CHARGE
export kilo, mega, giga, tera, mili, micro, nano, pico
export MKS,CGS,PARTICLE_PHYSICS
