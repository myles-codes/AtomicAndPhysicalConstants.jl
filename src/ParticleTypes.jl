# AtomicAndPhysicalConstants.jl/src/ParticleTypes.jl



abstract type AbstractSpecies end; export AbstractSpecies




	# -----------------------------------------------------------------------------------------------
	#=
	first define types for particle tracking: immutable for speed, data from a dictionary defined later 
	in this file is copied into one of these structs for particle tracking.
	=#
	
	
	"""
			SubatomicSpecies <: AbstractSpecies
	
	### Description:
	> immutable struct to be used for simulations of subatomic particle dynamics <
	
	### Fields:
	- `species_name`    -- AbstractString common name of particle
	- `charge`          -- charge on the particle in units of [e+]
	- `mass`            -- Float64 mass of given subatomic particle in [eV/c^2]
	- `other`           -- dictionary containing other attributes, eg 
												 spin and anomalous magnetic moment
	
	### Examples:
	- SubatomicSpecies("pion+", 1, 139.57018e6, other("anomalous_moment")=0.0, other("spin")=0.0)
	- SubatomicSpecies("electron", -1, 0.51099895000e6, 
		other("anomalous_moment")=anom_mag_moment_electron, other("spin")=0.5)
	""" SubatomicSpecies
	
	struct SubatomicSpecies <: AbstractSpecies
		species_name::AbstractString
		charge::Int32
		mass::Float64
		other::Dict{String,Float64}
	end; export SubatomicSpecies
	
	
	
	
	
	"""
			AtomicSpecies <: AbstractSpecies
	
	### Description:
	> immutable struct to be used for simulations of atomic particle dynamics <
	
	### Fields:
	- `species_name`    -- AbstractString periodic table symbol for element
	- `Z`               -- Integer atomic number (i.e. protons in the nucleus)
	- `charge`          -- Integer net charge on the atom in units of [e+]
	- `mass`            -- Float64 mass of given atomic isotope in [AMU]
	
	### Examples:
	- AtomicSpecies("Li", 3, 0, 6.9675)
	- AtomicSpecies("Ag", 47, -2, 107.8682)
	""" AtomicSpecies
	
	struct AtomicSpecies <: AbstractSpecies
		species_name::AbstractString
		Z::Int32
		charge::Int32
		mass::Float64
	end; export AtomicSpecies
	
	
	
	
	mutable struct MolecularSpeciesData
		species_name::AbstractString
		charge::Float64
		# mass::
		# other::Dict()
	end



# -----------------------------------------------------------------------------------------------
#=
In the following section, data types which carry all the information about particle species are 
defined: for now there are just atomic and subatomic particles
=#




"""
SubtomicSpeciesData <: AbstractSpeciesData

### Description:
> mutable struct to store all (possibly degenerate) information about a subatomic particle<

### Fields:
- `species_name`      -- AbstractString common name for (anti) baryon
- `charge`            -- electric charge on the given particle in units of [e+]
- `mass`              -- mass of the given particle in [eV/c^2]
- `anomalous_moment`  -- anomalous magnetic moment of particle
- `spin`              -- spin of the particle

### Notes:
some parameters in this struct are likely named constants from PhysicalConstants.jl

### Examples:
- SubatomicSpeciesData("neutron", 0, m_neutron, anom_mag_moment_neutron, 0.5)
- SubatomicSpeciesData("pion-", -1, m_pion_charged, 0.0, 0.0)
"""  SubatomicSpeciesData

mutable struct SubatomicSpeciesData
species_name::AbstractString              # common species_name of the particle
charge::Int                     # charge on the particle in units of e+
mass::Float64                     # mass of the particle in [eV/c^2]
anomalous_moment::Float64         # anomalous magnetic moment 
spin::Float64                     # spin magnetic moment in [ħ]
end; export SubatomicSpeciesData






"""
AtomicSpeciesData <: AbstractSpeciesData

### Description:
> mutable struct to store all (possibly degenerate) information about a particular element<

### Fields:
- `Z`               -- Integer atomic number (i.e. protons in the nucleus)
- `species_name`    -- AbstractString periodic table symbol for element
- `mass`            -- > Dict{Int, Float64}(isotope::Int, mass::Float64) isotope masses in [AMU]
									 > key -1 refers to the average common atomic mass, other keys refer to 
									 > the number of neutrons present in the isotope <

### Examples:
- AtomicSpeciesData(3, "Li", Dict(Int64, Float64)(-1 => 6.9675, 0 => 3.0308, 1 => 4.02719, 2 => 5.012538, 3 => 6.0151228874, 4 => 7.0160034366, 5 => 8.022486246, 6 => 9.02679019, 7 => 10.035483, 8 => 11.04372358, 9 => 12.052517, 10 => 13.06263))
- AtomicSpeciesData(47, "Ag", Dict(Int64, Float64)(-1 => 107.8682, 45 => 92.95033, 46 => 93.94373, 47 => 94.93602, 48 => 95.930744, 49 => 96.92397, 50 => 97.92156, 51 => 98.9176458, 52 => 99.9161154, 53 => 100.912684, 54 => 101.9117047, 55 => 102.9089631, 56 => 103.9086239, 57 => 104.9065256, 58 => 105.9066636, 59 => 106.9050916, 60 => 107.9059503, 61 => 108.9047553, 62 => 109.9061102, 63 => 110.9052959, 64 => 111.9070486, 65 => 112.906573, 66 => 113.908823, 67 => 114.908767, 68 => 115.9113868, 69 => 116.911774, 70 => 117.9145955, 71 => 118.91557, 72 => 119.9187848, 73 => 120.920125, 74 => 121.923664, 75 => 122.925337, 76 => 123.92893, 77 => 124.93105, 78 => 125.93475, 79 => 126.93711, 80 => 127.94106, 81 => 128.94395, 82 => 129.9507))
""" AtomicSpeciesData

mutable struct AtomicSpeciesData
Z::Int                      # number of protons
species_name::AbstractString          # periodic table element symbol
mass::Dict{Int,Float64}     # a dict to store the masses, keyed by isotope
#=
keyvalue -1 => average mass of common isotopes,
keyvalue n ∈ {0} ∪ N is the number of neutrons
		which gives the mass value
=#
end; export AtomicSpeciesData



