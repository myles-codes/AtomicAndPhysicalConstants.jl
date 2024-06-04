# AtomicAndPhysicalConstants.jl/src/ParticleFunctions.jl



# ------------------------------------------------------------------------------------------------------------
# the set_species function has been replaced by Particle, which is in ParticleTypes.jl for now. I'll alter the 
# rest of these functions to match soon.



"""
		Particle(name::AbstractString, charge::Int=0, iso::Int=-1)

Create a particle struct for tracking and simulation.

# Arguments
1. `name::AbstractString`: the name of the particle 
		* subatomic particle names must be given exactly,
		* Atomic symbols may include charge and isotope eg Li#9+1
		* where #[1-999] specifies the isotope and (+/-)[0-999] specifies charge
2. `charge::Int=0`: the charge of the particle.
		* only affects atoms 
		* overwritten if charge given in the name
3. `iso::Int` the mass number of the atom
		* only affects atoms 
		* overwritten if charge given in the name
""" Particle

function Particle(name::AbstractString, charge::Int=0, iso::Int=-1)

	# check subatomics first so we don't accidentally strip a name
	if haskey(Subatomic_Particles, name) # is the particle in the Subatomic_Particles dictionary?
		# write the particle out directly
		return Particle(name, Subatomic_Particles[name].charge,
			Subatomic_Particles[name].mass,
			Subatomic_Particles[name].spin,
			Subatomic_Particles[name].anomalous_moment)
	else


		# define regex for the name String

		rgas = r"[A-Z][a-z]|[A-Z]" # atomic symbol regex
		rgm = r"#[0-9]|#[0-9][0-9]|#[0-9][0-9][0-9]" # atomic mass regex
		rgcp = r"\+[0-9]|\+[0-9][0-9]|\+[0-9][0-9][0-9]" # positive charge regex
		rgcm = r"\-[0-9]|\-[0-9][0-9]|\-[0-9][0-9][0-9]" # negative charge regex

		AS = match(rgas, name) # grab just the atomic symbol
		isom = match(rgm, name)
		if typeof(isom) != Nothing
			isostr = strip(isom.match, '#')
			iso = tryparse(Int, isostr)
		end
		if occursin(rgcp, name) == true
			chstr = match(rgcp, name)
			charge = tryparse(Int, strip(chstr, "+"))
		elseif occursin(rgcm, name) == true
			chstr = match(rgcm, name)
			charge = tryparse(Int, chstr)
		end
		

		if haskey(Atomic_Particles, AS.match) # is the particle in the Atomic_Particles dictionary?
			if iso ∉ keys(Atomic_Particles[name].mass) # error handling if the isotope isn't available
				println("The isotope you specified is not available.")
				println("Isotopes are specified by the atomic symbol and integer mass number.")
				return
			end
			mass = begin
				nmass = Atomic_Particles[name].mass[iso] # mass of the neutrally charged isotope in amu
				nmass * (eV_per_amu) + m_electron * (Atomic_Particles[name].Z - charge) # put it in eV/c^2 and remove the electrons
				end
			if iso == -1 # if it's the average, make an educated guess at the spin
				partonum = round(nmass)
				spin = 0.5 * partonum
			else # otherwise, use the sum of proton and neutron spins
				spin = 0.5 * iso
			end
				return Particle(name, charge, mass, spin, 0) # return the object to track


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
end; export Particle


# ------------------------------------------------------------------------------------------------------------


"""
    charge_per_mass(particle::Particle)

Calculate the charge per unit mass in whichever unit system you're using.
""" charge_per_mass

function charge_per_mass(particle::Particle)
  return particle.charge/particle.mass
end; export charge_per_mass


# ------------------------------------------------------------------------------------------------------------


"""
		atomicnumber(particle::Particle)

Get the atomic number (positive nuclear charge) of a tracked particle.
""" atomicnumber

function atomicnumber(particle::Particle)
	if haskey(Atomic_Particles, particle.name)
		return Atomic_Particles[name].Z
	else
		print(f"{particle.name} is not an atom, and thus no atomic number.")
		return
	end
end; export atomicnumber
