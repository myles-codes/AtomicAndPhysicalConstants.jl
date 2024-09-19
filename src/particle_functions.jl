# AtomicAndPhysicalConstants.jl/src/ParticleFunctions.jl




# ------------------------------------------------------------------------------------------------------------


"""
    charge_per_mass(particle::Species)

Calculate the charge per unit mass in whichever unit system you're using.
""" charge_per_mass

function charge_per_mass(particle::Species)
  return particle.charge/particle.mass
end; export charge_per_mass


# ------------------------------------------------------------------------------------------------------------


"""
		atomicnumber(particle::Species)

Get the atomic number (positive nuclear charge) of a tracked particle.
""" atomicnumber

function atomicnumber(particle::Species)
	if haskey(Atomic_Particles, particle.name)
		return Atomic_Particles[name].Z
	else
		print(f"{particle.name} is not an atom, and thus no atomic number.")
		return
	end
end; export atomicnumber



# ------------------------------------------------------------------------------------------------------------

"""
		gyromagnetic_anomaly(gs::Float64)

Compute and deliver the gyromagnetic anomaly for a lepton given its g factor

# Arguments:
1. `gs::Float64': the g_factor for the particle
""" gyromagnetic_anomaly

function gyromagnetic_anomaly(gs::Float64)
	return (gs-2)/2
end


"""
		g_nucleon(gs::Float64, Z::Int, mass::Float64)

Compute and deliver the gyromagnetic anomaly for a baryon given its g factor

# Arguments:
1. `gs::Float64': the g_factor for the particle
2. `Z::Int': the charge (in units of +e) of the particle
3. `mass::Float64': the mass of the particle
""" g_nucleon

function g_nucleon(gs::Float64, Z::Int, mass::Float64)
	return Z*(m_proton/mass)*gs
end