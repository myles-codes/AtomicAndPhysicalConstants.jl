include("PhysicalConstants.jl")

"""
    Unit

    ### Description:
    > abstract type for storing units <

""" Unit

abstract type Unit end

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
    > units includes: amu, kg, g, eV<

    ### Example:
    MASS.amu is the unit 'amu', it refers the the struct Mass("amu",1.0)

""" MASS

const MASS = (amu = Mass("amu",1.0), 
        kg = Mass("kg",kg_per_amu), 
        eV = Mass("eV",eV_per_amu), 
        g = Mass("g",kg_per_amu/1000))

"""
    Length<:Unit

    ### Description:
    > immutable struct to be used for storing length units<
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
    > units includes: m, cm<

    ### Example:
    LENGTH.m is the unit 'meter', it refers the the struct Length("m",1.0)

""" LENGTH

LENGTH = (m = Length("m",1.0), cm = Length("cm",100.0))

"""
    UnitSystem

    ### Description:
    > immutable struct for storing unit systems<

    ### Fields:
	- `mass`                    -- type:Mass, stores the unit for mass
	- `length`                  -- type:Length, stores the unit for length

""" UnitSystem

struct UnitSystem
    mass::Mass
    length::Length
end

const PARTICLE_PHYSICS = UnitSystem(MASS.amu,LENGTH.m)
const MKS = UnitSystem(MASS.kg,LENGTH.m)
const CGS = UnitSystem(MASS.g,LENGTH.cm)

"""
    setunits

    ### Description:
    > set global non constants to the value in units specified<
    > users can specify the unit system and modify units in the system by keyword parameters<

    ### positional parameters:
    - 'unitsystem'                  -- type:UnitSystem, specify the unit system, default to PARTICLE_PHYSICS

    ### keyword parameters:
	- `mass`                        -- type:Mass, unit for mass, default to the mass unit in 'unitsystem'
	- `length`                      -- type:Length, unit for length, default to the length unit in 'unitsystem'

""" setunits

function setunits(unitsystem::UnitSystem=PARTICLE_PHYSICS; mass::Mass=unitsystem.mass, length::Length=unitsystem.length)
    println(mass.name)
    println(length.name)
end

#tests
setunits()
#prints: 
#amu
#m

setunits(MKS)
#prints: 
#kg
#m

setunits(MKS,length=LENGTH.cm)
#prints: 
#kg
#cm

setunits(length=LENGTH.cm)
#prints: 
#amu
#cm