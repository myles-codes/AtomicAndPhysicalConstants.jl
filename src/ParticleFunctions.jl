# AtomicAndPhysicalConstants.jl/src/ParticleFunctions.jl



# ------------------------------------------------------------------------------------------------------------
# the set_species function has been replaced by Particle, which is in ParticleTypes.jl for now. I'll alter the 
# rest of these functions to match soon.



"""
Particlek takes one positional argument (particle name), and two
keyword arguments, charge and isotope number.

if the particle name is in either atomic or subatomic particle libraries,
set_track returns a Particle object with the given attributes:
in the case of an atomic element it modifies the mass and charge based 
on the isotope and charge indicated, and in the case of a subatomic particle 
it just copies over the particle information.
Molecular particle functionality will be added as the particles are added to 
the library.
"""
Particle

function Particle(name::String, charge=0, iso=-1)

	# define regex for the name String

	rgas = r"[A-Z][a-z]|[A-Z]"
	rgm = r"#[0-9]|#[0-9][0-9]|#[0-9][0-9][0-9]"
	rgcp = r"\+[0-9]|\+[0-9][0-9]|\+[0-9][0-9][0-9]"
	rgcm = r"\-[0-9]|\-[0-9][0-9]|\-[0-9][0-9][0-9]"
	nm = match(rgas, name)
	if haskey(Atomic_Particles, nm)
		name = nm
	

	if haskey(Atomic_Particles, name) # is the particle in the Atomic_Particles dictionary?
		if iso ∉ keys(Atomic_Particles[name].mass) # error handling if the isotope isn't available
			println("The isotope you specified is not available.")
			println("Isotopes are specified by the atomic symbol and integer mass number.")
			return
		end
		mass = begin
			nmass = Atomic_Particles[name].mass[iso] # mass of the neutrally charged isotope in amu
			nmass * (kg_per_amu / kg_per_eV) + m_electron * (Atomic_Particles[name].Z - charge) # put it in eV/c^2 and remove the electrons
			end
		if iso == -1 # if it's the average, make an educated guess at the spin
			partonum = round(nmass)
			spin = 0.5 * partonum
		else # otherwise, use the sum of proton and neutron spins
			spin = 0.5 * iso
		end
			return Particle(name, charge, mass, spin, 0) # return the object to track

	elseif haskey(Subatomic_Particles, name) # is the particle in the Subatomic_Particles dictionary?
		# write the particle out directly
		return Particle(name, Subatomic_Particles[name].charge,
			Subatomic_Particles[name].mass,
			Subatomic_Particles[name].spin,
			Subatomic_Particles[name].anomalous_moment)

	else # handle the case where the given name is garbage
		println("The specified particle name does not exist in this library.")
		println("Available subatomic particles are: ")
		for p in keys(Subatomic_Particles)
			println(p)
		end
		println("Available atomic elements are")
		for p in keys(Atomic_Particles)
			println(p)
		end
		return
	end

end

export Particle


# ------------------------------------------------------------------------------------------------------------


"""
    function `charge_per_mass`(particle::Particle)

### Description:
> Routine takes in a tracked particle object
> to return charge/mass <

### Inputs:
- particle             -- tracked particle object

### Output:
- `charge_per_mass`    -- ratio of integer charge to mass of given particle

### Notes:
>simple function to pull data from the tracked object<
""" charge_per_mass

function charge_per_mass(particle::Particle)
  return particle.charge/particle.mass
end; export charge_per_mass


function atomicnumber(particle::Particle)

	if haskey(Atomic_Particles, particle.name)
		return Atomic_Particles[name].Z

	else
		print(f"{particle.name} is not an atom, and thus no atomic number.")
		return
	end

end
