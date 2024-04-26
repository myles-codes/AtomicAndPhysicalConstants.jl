
include("PhysicalConstants.jl")
include("ParticleTypes.jl")
"""
    Unit

    ### Description:
    > abstract type for storing units <

""" Unit

abstract type Unit end

# overriding how Units are printed

Base.print(io::IO, unit::T) where T<: Unit = print(io, " \"",unit.name,"\" \t\t where ",unit.conversion," ",unit.name,"\t = 1 ")

"""
    scale

    ### Description:
    > return scaled units that has prefix 'prefix' and is scaled by 'factor' <

""" scale

function scale(unit::T,prefix::AbstractString,factor::Float64) where T<: Unit
    return T(prefix*unit.name,unit.conversion/factor)
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
    println("charge:\t",current_units[2],"e")
    return
end

"""
    prefix

    ### Description:
    > dictionary that store how scaling factors relate to prefixs<

""" prefix

prefix::Dict{AbstractString,Float64} = Dict(
    "k" =>10^3,
    "kilo" =>10^3,
    "Kilo" =>10^3,
    "M" =>10^6,
    "mega" =>10^6,
    "Mega" =>10^6,
    "G" =>10^9,
    "giga" =>10^9,
    "Giga" =>10^9,
    "T" =>10^12,
    "tera" =>10^12,
    "Tera" =>10^12,
    "m" =>10^-3,
    "mili" =>10^-3,
    "mu" =>10^-6,
    "micro" =>10^-6,
    "n" =>10^9,
    "nano" =>10^9,
    "p" =>10^12,
    "pico" =>10^-12,
)

UNIT::Dict{AbstractString,Unit} = Dict(
    "amu" => Mass("amu",1.0), 
    "eV"=> Mass("eV/c^2",eV_per_amu),
    "eV/c^2"=> Mass("eV/c^2",eV_per_amu),
    "g" => Mass("g",kg_per_amu*10^3), 
    "kg" => Mass("kg",kg_per_amu),
    "C" => Charge("C", e_charge),
    "e" => Charge("e",1.0)
)

"""
    tounits

    ### Description:
    > return the correponding unit for the given symbol<

    ### keyword parameters:
	- `unit`                        -- type: Symbol, name of the unit


""" tounit

function tounit(unit::Symbol)
    name = string(unit)
    for (key,value) in prefix
        if startswith(name, key)
            name_without_prefix = name[length(key) + 1:end]
            if haskey(UNIT,name_without_prefix)
                return scale(UNIT[name_without_prefix],key,value)
            end
        end
    end
    throw(ArgumentError("unit \""*string(unit)*"\" does not exist"))
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

""" UnitSystem

struct UnitSystem
    mass::Mass
    charge::Charge
end

PARTICLE_PHYSICS = UnitSystem(UNIT["amu"],UNIT["e"])
MKS = UnitSystem(UNIT["kg"],UNIT["C"])
CGS = UnitSystem(UNIT["g"],UNIT["C"])

"""
    setunits

    ### Description:
    > return nothing<
    > users can specify the unit system and modify units in the system by keyword parameters<
    > sets global unit and store them in current units<
    
    ### default units
    mass: amu
    charge: elementary charge

    ### positional parameters:
    - 'unitsystem'                  -- type:Symbol, specify the unit system, default to PARTICLE_PHYSICS, it provides a convient way to set all the units

    ### keyword parameters:
	- `mass`                        -- type:Symbol, unit for mass, default to the mass unit in 'unitsystem'
    - `charge`                      -- type:Symbol, unit for energy, default to the energy unit in 'unitsystem'


""" setunits

function setunits(unitsystem::Symbol = :default; 
    mass::Symbol = :default, 
    charge::Symbol = :default,
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
        throw(ArgumentError("unit system \""*string(unitsystem)*"\" does not exist"))
    end

    # get Unit struct from Symbol
    mass_unit::Mass = unit_system.mass
    if mass == :default
        mass_unit = unit_system.mass
    else
        mass_unit = tounit(mass)
    end
        
    charge_unit::Charge = unit_system.charge
    if charge == :default
        charge_unit = unit_system.charge
    else
        charge_unit = tounit(charge)
    end
    
    # record what units is currently being used
    empty!(current_units)
    push!(current_units,mass_unit)
    push!(current_units,charge_unit)
    
    return
end

"""
    massof

    ### Description:
    > return mass of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                        -- type:particle, the particle whose mass you want to know
    - `unit`                      -- type:Symbol, default to the unit set from setunits(), the unit of the mass variable

""" massof

function massof(particle::Particle, unit::Symbol =:default)
    if(unit==:defualt)
        return particle.mass*current_units[1].conversion
    else
        mass::Mass  = tounit(unit)
        return particle.mass*mass.conversion
    end
end

"""
    chargeof

    ### Description:
    > return charge of 'particle' in current unit or unit of the user's choice<

    ### parameters:
	- 'particle`                        -- type:particle, the particle whose charge you want to know
    - `unit`                      -- type:Symbol, default to the unit set from setunits(), the unit of the charge variable

""" chargeof

function chargeof(particle::Particle, unit::Symbol =:default)
    if(unit==:defualt)
        return particle.charge*current_units[2].conversion
    else
        charge::Charge  = tounit(unit)
        return particle.charge*charge.conversion
    end
end

export setunits, printunits
export massof, chargeof


