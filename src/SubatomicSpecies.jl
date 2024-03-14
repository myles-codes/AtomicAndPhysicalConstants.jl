

# AtomicAndPhysicalConstants.jl/ParticleSpecies.jl

# include("ParticleTypes.jl")
# -----------------------------------------------------------------------------------------------
#=
Below we have two dictionaries: Subatomic_Particles and Atomic_Particles:
these contatin key=>value pairs of (respectively) subatomic-name => SubatomicSpeciesData
and atomic-name => AtomicSpeciesData
=#




"""
    Subatomic_Particles 
a dictionary of all the available subatomic species; 
the key is the particle's species_name, 
and the value is the relevant SubatomicSpecies struct, _eg_ 

Subatomic_Particles["some-particle"] = SubatomicSpeciesData("some-particle", ...)
""" Subatomic_Particles

Subatomic_Particles = Dict{AbstractString, SubatomicSpeciesData}(
  "pion0"             => SubatomicSpeciesData("pion0", 0, m_pion_0, 0.0, 0.0),
  # const ref_species       = SubatomicSpeciesData("Ref_Particle", "Garbage!", 0, 0.0, 0.0, NaN)
  "neutron"           => SubatomicSpeciesData("neutron", 0, m_neutron, anom_mag_moment_neutron, 0.5),
  "deuteron"          => SubatomicSpeciesData("deuteron", 1, m_deuteron, anom_mag_moment_deuteron, 1.0),
  "pion+"             => SubatomicSpeciesData("pion+", 1, m_pion_charged, 0.0, 0.0),
  "antimuon"          => SubatomicSpeciesData("anti-muon", 1, m_muon, anom_mag_moment_muon, 0.5),
  "proton"            => SubatomicSpeciesData("proton", 1, m_proton, anom_mag_moment_proton, 0.5),
  "positron"          => SubatomicSpeciesData("positron", 1, m_electron, anom_mag_moment_electron, 0.5),
  "photon"            => SubatomicSpeciesData("photon", 0, 0.0, 0.0, 0.0),
  "electron"          => SubatomicSpeciesData("electron", -1, m_electron, anom_mag_moment_electron, 0.5),
  "antiproton"        => SubatomicSpeciesData("anti-proton", -1, m_proton, anom_mag_moment_proton, 0.5),
  "muon"              => SubatomicSpeciesData("muon", -1, m_muon, anom_mag_moment_muon, 0.5),
  "pion-"             => SubatomicSpeciesData("pion-", -1, m_pion_charged, 0.0, 0.0),
  "anti_deuteron"     => SubatomicSpeciesData("anti-deuteron", -1, m_deuteron, anom_mag_moment_deuteron, 1.0),
  "anti_neutron"      => SubatomicSpeciesData("anti-neutron", 0, m_neutron, anom_mag_moment_neutron, 0.5)
  # const anti_ref_species  = SubatomicSpeciesData("Anti_Ref_Particle", "Garbage!", 0, 0.0, 0.0, NaN)
); export Subatomic_Particles



