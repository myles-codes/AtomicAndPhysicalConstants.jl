# AtomicAndPhysicalConstants.jl/ParticleFunctions.jl



# ------------------------------------------------------------------------------------------------------------


"""
function set_species:
* arguments: (species_name::AbstractString, [isotope::Integer], [charge::Integer])
* returns ref_particle::AbstractSpecies
\n
description:
> routine to set an object for use in simulations and computations given the name of the particle <
\n
inputs:
  - species_name::AbstractString        -- name of particle species,
                                         if blank function breaks
  - [charge::Integer]                   -- set the charge of an atomic particle,
                                         the default behavior uses a neutral atom
  - [isotope::Integer]                  -- use a particular atomic isotope,
                                         the default behavior is to use the average atomic mass

output:
  -ref_particle::AbstractSpecies       -- immutable particle object for use in 
                                         simulations 
\n
notes:
> set_species searches the subatomic and atomic particle dictionaries for a particle 
> matching positional arg species_name = Dict(key).species_name (with key = species_name) 
> and if found constructs an AbstractSpecies object containing the data associated to
> species_name for use in computation/simulation:
> optional charge and isotope keyword args come into play if and only if species_name
> refers to an atomic particle; charge allows a non-neutral atom, and isotope allows 
> selection of any available isotope mass <
""" set_species

function set_species(species_name::AbstractString, charge::Int=0, isotope::Int=-1)
  # first check if we have a known subatomic particle and grab its qualities
  if haskey(Subatomic_Particles, species_name) == true
    ref = Subatomic_Particles[species_name] # pull in the info so we don't make repeated dictionary calls
    # now set the reference particle
    ref_particle = SubatomicSpecies(ref.species_name, ref.charge, ref.mass, 
                                    Dict("anomalous_moment" => ref.anomalous_moment, "spin" => ref.spin))
  #= then check if the specified particle is one of the known atoms: 
  if no isotope is given, use the common average mass =#
  elseif haskey(Atomic_Particles, species_name)
    ref = Atomic_Particles[species_name] # pull in the info so we don't make repeated dictionary calls
    # set the reference particle
    ref_particle = AtomicSpecies(ref.species_name, ref.Z, charge, ref.mass[isotope])
  end
  return ref_particle # return the static reference particle
end; export set_species


# ------------------------------------------------------------------------------------------------------------


"""
function charge_per_mass:
* arguments: (species_name::AbstractString, [isotope::Integer], [charge::Integer])
* returns: charge_per_mass::Float64
\n
description: 
> Routine takes in the name of a particle and optionally a charge and isotope number,
> to return charge/mass <
\n
inputs:
  - species_name::AbstractString        -- name of particle species,
                                         if blank function breaks
  - [charge::Integer]                   -- set the charge of an atomic particle,
                                         the default behavior uses a neutral atom
  - [isotope::Integer]                  -- use a particular atomic isotope,
                                         the default behavior is to use the average atomic mass
\n
output:
  - charge_per_mass::Float64            -- ratio of integer charge to mass of given particle
\n
notes:
> function searches the known dictionaries of subatomic particles for a particle matching 
> species_name = Dict(key).species_name (with key = species_name) and if found returns 
> Dict(key).charge/Dict(key).mass:
> optional 'charge' and 'isotope' arguments only have any effect if species_name refers to an 
> atomic particle: in this case the atom is taken to have charge = charge::Int, and the atomic 
> mass is set by the isotope <
""" charge_per_mass

function charge_per_mass(species_name::AbstractString, charge::Int = 0, isotope::Int = -1)
  # check if subatomic
  if haskey(Subatomic_Particles, species_name) == true
    # return the ratio charge/mass
    return Subatomic_Particles[species_name].charge/Subatomic_Particles[species_name].mass
  # check if atomic nucleus
  elseif haskey(Atomic_Particles, species_name) == true
    return charge/Atomic_Particles[species_name].mass[isotope]
  end
end; export charge_per_mass



