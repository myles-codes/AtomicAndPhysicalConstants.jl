# AtomicAndPhysicalConstants.jl/ParticleFunctions.jl



# ------------------------------------------------------------------------------------------------------------


"""
Function set_species:
Arguments: (species_name, (optional) isotope #, (optional) charge) 
Returns immutable 'AtomicSpecies' || 'SubatomicSpecies' struct

Routine to set an object for use in simulations and computations given the name of the particle.

Input:
  species_name        -- AbstractString: name of particle species,
                         if blank function breaks
  isotope             -- Optional Integer: use a particular atomic isotope,
                         the default behavior is to use the average atomic mass
  charge              -- Optional Integer: set the charge of an atomic particle,
                         the default behavior uses a neutral atom

Output:
  reference_particle  -- AbstractSpecies: immutable particle reference 
""" set_species

function set_species(species_name::AbstractString, isotope::Int = -1, charge::Int = 0)
  # first check if we have a known subatomic particle and grab its qualities
  if haskey(Subatomic_Particles, species_name) == true
    ref = Subatomic_Particles[species_name] # pull in the info so we don't make repeated dictionary calls
    # now set the reference particle
    reference_particle = SubatomicSpecies(ref.species_name, ref.charge, ref.mass, 
                                    Dict("anomalous_moment" => ref.anomalous_moment, "spin" => ref.spin))
  #= then check if the specified particle is one of the known atoms: 
  if no isotope is given, use the common average mass =#
  elseif haskey(Atomic_Particles, species_name)
    ref = Atomic_Particles[species_name] # pull in the info so we don't make repeated dictionary calls
    # set the reference particle
    reference_particle = AtomicSpecies(ref.species_name, ref.Z, charge, ref.mass[isotope])
  end
  return reference_particle # return the static reference particle
end; export set_species


# ------------------------------------------------------------------------------------------------------------


"""
Function charge_per_mass:
Arguments: (species_name, (optional) isotope #, (optional) charge)
Returns: Float64 charge/mass

Routine takes in the name of a particle, and optionally a charge and isotope to return charge/mass

Inputs:
  species_name        -- AbstractString: name of particle species,
                         if blank function breaks
  isotope             -- Optional Integer: use a particular atomic isotope,
                         the default behavior is to use the average atomic mass
  charge              -- Optional Integer: set the charge of an atomic particle,
                         the default behavior uses a neutral atom

Outputs:
  charge/mass         -- Float64: ratio of integer charge to mass of given particle
""" chargePerMass

function charge_per_mass(species_name::AbstractString, charge::Int = 0, isotope::Int = -1)
  # check if subatomic
  if haskey(Subatomic_Particles, lowercase(species_name)) == true
    # return the ratio charge/mass
    return Subatomic_Particles[species_name].charge/Subatomic_Particles[species_name].mass
  # check if atomic nucleus
  elseif haskey(Atomic_Particles, species_name) == true
    return charge/Atomic_Particles[species_name].mass[isotope]
  end
end; export charge_per_mass



