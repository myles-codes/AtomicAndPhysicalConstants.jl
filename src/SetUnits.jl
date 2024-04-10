include("PhysicalConstants.jl")
include("Global.jl")

"""
    Unit

    ### Description:
    > abstract type for storing units <

""" Unit

abstract type Unit end

# scaling functions that turns unit to kilo-unit, mega-unit, etc

"""
    k

    ### Description:
    > takes in a Unit 'unit' and return kilo-'unit' <
    > puts a k in its name and make unit.conversion into unit.conversion/10^3

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" k

function k(unit::T) where T <: Unit
    return T("k"*unit.name,unit.conversion/10^3)
end

"""
    m

    ### Description:
    > takes in a Unit 'unit' and return mega-'unit' <
    > puts a M in its name and make unit.conversion into unit.conversion/10^6

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" M

function M(unit::T) where T <: Unit
    return T("M"*unit.name,unit.conversion/10^6)
end

"""
    G

    ### Description:
    > takes in a Unit 'unit' and return giga-'unit' <
    > puts a G in its name and make unit.conversion into unit.conversion/10^9

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" G

function G(unit::T) where T <: Unit
    return T("G"*unit.name,unit.conversion/10^9)
end

"""
    T

    ### Description:
    > takes in a Unit 'unit' and return tera-'unit' <
    > puts a T in its name and make unit.conversion into unit.conversion/10^12

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" T

function T(unit::U) where U <: Unit
    return U("T"*unit.name,unit.conversion/10^12)
end

"""
    m

    ### Description:
    > takes in a Unit 'unit' and return mili-'unit' <
    > puts a m in its name and make unit.conversion into unit.conversion/10^-3

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" m

function m(unit::T) where T <: Unit
    return T("m"*unit.name,unit.conversion/10^-3)
end

"""
    mu

    ### Description:
    > takes in a Unit 'unit' and return micro-'unit' <
    > puts a mu- in its name and make unit.conversion into unit.conversion/10^-6

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" mu

function mu(unit::T) where T <: Unit
    return T("mu-"*unit.name,unit.conversion/10^-6)
end

"""
    n

    ### Description:
    > takes in a Unit 'unit' and return nano-'unit' <
    > puts a n in its name and make unit.conversion into unit.conversion/10^-9

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" n

function n(unit::T) where T <: Unit
    return T("n"*unit.name,unit.conversion/10^-9)
end

"""
    p

    ### Description:
    > takes in a Unit 'unit' and return pico-'unit' <
    > puts a p in its name and make unit.conversion into unit.conversion/10^-12

    ### parameters:
    - 'unit'                  -- subtype of Unit

""" p

function p(unit::T) where T <: Unit
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
    > a constant name tuple for storing all the units for mass<
    > units includes: amu, eV/c^2, keV/c^2, MeV/c^2, GeV/c^2, kg, g, mg<

    ### Example:
    MASS.amu is the unit 'amu', it refers the the struct Mass("amu",1.0)

""" MASS

MASS = (amu = Mass("amu",1.0), 
    eV = Mass("eV",__b_eV_per_amu),
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
    > a constant name tuple for storing all the units for length<
    > units includes: m, cm, mm, km<

    ### Example:
    LENGTH.m is the unit 'meter', it refers the the struct Length("m",1.0)

""" LENGTH

LENGTH = (m = Length("m",1.0), 
    cm = Length("cm",100.0),
    A = Length("Å",10^10))

"""
    Time<:Unit

    ### Description:
    > immutable struct to be used for storing time units<
    > the basis for conversion is second<

    ### Fields:
	- `name`                        -- type:AbstractString, name of the unit
	- `conversion`                  -- type:FLoat, 'conversion' unit = 1 second

""" Time

struct Time<:Unit
    name::AbstractString
    conversion::Float64
end

"""
    TIME
    ### Description:
    > a constant name tuple for storing all the units for time<
    > units includes: s, minute, hour<

    ### Example:
    TIME.s is the unit 'second', it refers the the struct Length("s",1.0)

""" TIME

TIME = (s = Time("s",1.0),
    minute = Time("minute",1/60),
    hour = Time("hour",1/3600),)

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
Base.:/(a::Length, b::Time) = Speed(a.name*"/"*b.name,a.conversion/b.conversion)

"""
    Speed
    ### Description:
    > a constant name tuple for storing all the units for speed<
    > units includes: c, m/s<

""" SPEED

SPEED = (c = Speed("c",1/__b_c_light), m_per_s = LENGTH.m/TIME.s)

"""
    UnitSystem

    ### Description:
    > immutable struct for storing unit systems<

    ### Fields:
	- `mass`                    -- type:Mass, stores the unit for mass
	- `length`                  -- type:Length, stores the unit for length
    - `time`                    -- type:Time, stores the unit for time

""" UnitSystem

struct UnitSystem
    mass::Mass
    length::Length
    time::Time
end

PARTICLE_PHYSICS = UnitSystem(MASS.amu,LENGTH.m,TIME.s)
MKS = UnitSystem(MASS.kg,LENGTH.m,TIME.s)
CGS = UnitSystem(MASS.g,LENGTH.cm,TIME.s)


"""
    setunits

    ### Description:
    > set global non constants to the value in units specified<
    > users can specify the unit system and modify units in the system by keyword parameters<
    
    ### default units
    mass: amu
    length: m
    time: s

    ### positional parameters:
    - 'unitsystem'                  -- type:UnitSystem, specify the unit system, default to PARTICLE_PHYSICS

    ### keyword parameters:
	- `mass`                        -- type:Mass, unit for mass, default to the mass unit in 'unitsystem'
	- `length`                      -- type:Length, unit for length, default to the length unit in 'unitsystem'
    - `time`                        -- type:Time, unit for time, default to the time unit in 'unitsystem'
    - `speed`                       -- type:Speed, unit for speed, default to the length unit in 'unitsystem'/time unit in 'unitsystem'. speed is also default to 'length'/'time' unit unless specified. 

""" setunits

function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS; 
    mass::Mass = unitsystem.mass, 
    length::Length = unitsystem.length,
    time::Time = unitsystem.time,
    speed::Speed = length/time
    )
    
    # convert all the variables with dimension mass
    global m_electron = mass.conversion * __b_m_electron / __b_eV_per_amu       # Electron Mass 
    global m_proton = mass.conversion * __b_m_proton / __b_eV_per_amu           # Proton Mass 
    global m_neutron = mass.conversion * __b_m_neutron / __b_eV_per_amu         # Neutron Mass 
    global m_muon = mass.conversion * __b_m_muon  / __b_eV_per_amu              # Muon Mass 
    global m_helion = mass.conversion * __b_m_helion / __b_eV_per_amu           # Helion Mass He3 nucleus 
    global m_deuteron = mass.conversion * __b_m_deuteron / __b_eV_per_amu       # Deuteron Mass 

    # convert all the variables with dimension length
    global r_e = length.conversion * __b_r_e                                    # classical electron radius

    # convert all the variables with dimension speed
    global c_light = speed.conversion * __b_c_light                                    # classical electron radius
end