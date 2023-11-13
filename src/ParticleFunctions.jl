# AtomicAndPhysicalConstants.jl/ParticleFunctions.jl





"""setref is a function to pull information from the 'ParticleSpecies' library
(with a possible charge assignment for atomic particles) and assign that 
information to an immutable struct 'RefSpecies'""" setref

function setref(name::String = "electron", isotope::Int = -1, newcharge::Int = 0)
  #=
  first check if we have a known subatomic particle
  and grab its qualities
  =#
  if haskey(Subatomic_Particles, lowercase(name)) == true
    ref = Subatomic_Particles[name] # pull in the info so we don't make a jillion dictionary calls
    # now set the reference particle
    reference_particle = SubatomicSpecies(ref.name, ref.charge, ref.mass, 
                                    Dict("anomalous_moment" => ref.anomalous_moment, "spin" => ref.spin))
  #=
  then check if the specified particle is
  one of the known atoms:
  if no isotope is given, use the common 
  average mass
  =#
  elseif haskey(Atomic_Particles, name)
    ref = Atomic_Particles[name] # pull in the info so we don't make a jillion dictionary calls
    # set the reference particle
    reference_particle = AtomicSpecies(ref.name, ref.Z, newcharge, ref.mass[isotope])
  end
  # return the static reference particle
  return reference_particle
end; export setref




"""chargePerMass takes in the name of a particle, with optional charge and isotope keys
note the isotope key is the number of neutrons in the atomic nucleus;
function returns the charge of the particle divided by its mass""" chargePerMass

function charge_per_mass(name::String = "electron", charge::Int32 = 0, isotope::Int32 = -1)
  if haskey(Subatomic_Particles, lowercase(name)) == true
    return Subatomic_Particles[name].charge/Subatomic_Particles[name].mass
  elseif haskey(Atomic_Particles, name) == true
    return charge/Atomic_Particles[name].mass[isotope]
  end
end; export charge_per_mass



