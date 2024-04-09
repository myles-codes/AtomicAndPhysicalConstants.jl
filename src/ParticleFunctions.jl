# AtomicAndPhysicalConstants.jl/src/ParticleFunctions.jl



# ------------------------------------------------------------------------------------------------------------


"""
    function `set_species`(species_name::AbstractString, [isotope]::Integer=-1, [charge]::Integer=1)

### Description:
> routine to set an object for use in simulations and computations given the name of the particle <

### Input:
- `species_name`   -- name of particle species,if blank function breaks
- `charge`         -- (optional, default: '0')  charge of an atomic particle,
- `isotope`        -- (optional, default: '-1') selected atomic isotope, 
                            default uses the average

### Output:
- `ref_particle`      -- immutable particle object for use in 
                         simulations 

### Notes:
> `set_species` searches the subatomic and atomic particle dictionaries for a particle 
> matching positional arg `species_name` = `Dict(key).species_name` (with key = `species_name`) 
> and if found constructs an AbstractSpecies object containing the data associated to
> species_name for use in computation/simulation:
> optional charge and isotope keyword args come into play if and only if `species_name`
> refers to an atomic particle; charge allows a non-neutral atom, and isotope allows 
> selection of any available isotope mass 
> if `species_name` is an atomic sybmol with a charge modifier, _eg_ Li+2 or Na-1, the function
> treats the modifier as the net charge, which is to say
> `set_species`("Pb", charge=5) = `set_species`("Pb+5")
""" set_species

function set_species(species_name::AbstractString, charge::Int=0, isotope::Int=-1)
  # first check if we have a known subatomic particle and grab its qualities
  if haskey(Subatomic_Particles, species_name) == true
    ref = Subatomic_Particles[species_name] # pull in the info so we don't make repeated dictionary calls
    # now set the reference particle
    ref_particle = SubatomicSpecies(ref.species_name, ref.charge, ref.mass, 
                                    Dict("anomalous_moment" => ref.anomalous_moment, "spin" => ref.spin))
  #  then check if the specified particle is one of the known atoms: 
  # if no isotope is given, use the common average mass 
  elseif haskey(Atomic_Particles, species_name) == true
    ref = Atomic_Particles[species_name]
    ref_particle = AtomicSpecies(ref.species_name, ref.Z, charge, ref.mass[isotope])

  # check if the first two chars of species_name make up an atomic symbol
  elseif haskey(Atomic_Particles, species_name[1]) == true || haskey(Atomic_Particles, species_name[1:2]) == true
    p = findfirst('+', species_name) # see if the name modifies the charge up
    m = findfirst('-', species_name) # or down
    if typeof(m) == Nothing && typeof(p) == Int # if positive net charge
      ref = Atomic_Particles[species_name[1:p-1]] # grab the element data
      charge = tryparse(Int, species_name[p:end]) # and set the final charge
    elseif typeof(p) == Nothing && typeof(m) == Int # if negative net charge
      ref = Atomic_Particles[species_name[1:m-1]] # grab the element data
      charge = tryparse(Int, species_name[m:end]) # and set the final charge
    end
    # build a final static particle
    ref_particle = AtomicSpecies(ref.species_name, ref.Z, charge, ref.mass[isotope])
  end
  if abs(charge) > 127
    error(f"|charge| = {abs(charge)}, which is too big")
  else
    return ref_particle # return the static reference particle
  end
end; export set_species


# ------------------------------------------------------------------------------------------------------------


"""
    function `charge_per_mass`(`species_name`::AbstractString, [isotope]::Integer, [charge]::Integer)

### Description:
> Routine takes in the name of a particle and optionally a charge and isotope number,
> to return charge/mass <

### Inputs:
- `species_name`       -- name of particle species, if blank function breaks
- `charge`             -- (optional, default: '0')  charge of an atomic particle,
- `isotope`            -- (optional, default: '-1') selected atomic isotope, 
                            default uses the average
### Output:
- `charge_per_mass`    -- ratio of integer charge to mass of given particle

### Notes:
> function searches the known dictionaries of subatomic particles for a particle matching 
> `species_name` = `Dict(key).species_name` (with key = `species_name`) and if found returns 
> Dict(key).charge/Dict(key).mass:
> optional `charge` and `isotope` arguments only have any effect if `species_name` refers to an 
> atomic particle: in this case the atom is taken to have charge = `charge`::Int, and the atomic 
> mass is set by the isotope 
> if `species_name` is an atomic sybmol with a charge modifier, _eg_ Li+2 or Na-1, the function
> treats the modifier as the net charge, which is to say
> `charge_per_mass`("He", charge=2) = `charge_per_mass`("He+2")<
""" charge_per_mass

function charge_per_mass(species_name::AbstractString, charge::Int = 0, isotope::Int = -1)
  # check if subatomic
  if haskey(Subatomic_Particles, species_name) == true
    # return the ratio charge/mass
    return Subatomic_Particles[species_name].charge/Subatomic_Particles[species_name].mass
  # check if atomic nucleus
  elseif haskey(Atomic_Particles, species_name) == true
    return charge/Atomic_Particles[species_name].mass[isotope]
  elseif haskey(Atomic_Particles, species_name[1]) == true || haskey(Atomic_Particles, species_name[1:2]) == true
    p = findfirst('+', species_name) # see if the name modifies the charge up
    m = findfirst('-', species_name) # or down
    if typeof(m) == Nothing && typeof(p) == Int # if positive net charge
      charge = tryparse(Int, species_name[p:end]) # set the final charge
      return charge/Atomic_Particles[species_name[1:p-1]].mass[isotope]
    elseif typeof(p) == Nothing && typeof(m) == Int # if negative net charge
      charge = tryparse(Int, species_name[m:end]) # and set the final charge
      return charge/Atomic_Particles[species_name[1:m-1]].mass[isotope]
    end
  end
end; export charge_per_mass



