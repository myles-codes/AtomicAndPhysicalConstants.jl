# AtomicAndPhysicalConstants/src/PhysicalConstants.jl




# Global non-constants: type must be specified
# these are the dimensionful quantities which will change with change of units 

m_electron::Float64                  = 0      # Electron Mass 
m_proton::Float64                    = 0      # Proton Mass 
m_neutron::Float64                   = 0      # Neutron Mass 
m_muon::Float64                      = 0      # Muon Mass 
m_helion::Float64                    = 0      # Helion Mass He3 nucleus 
m_deuteron::Float64                  = 0      # Deuteron Mass 
c_light::Float64                     = 0      # speed of light 
h_planck::Float64                    = 0      # Planck's constant 
r_e::Float64                         = 0      # classical electron radius 
mu_0_vac::Float64                    = 0      # Vacuum permeability  
eps_0_vac::Float64                   = 0      # Permittivity of free space 

e_charge::Float64                    = 0      # elementary charge 

anom_mag_moment_electron::Float64    = 0      # anomalous mag. mom. of the electron 
anom_mag_moment_muon::Float64        = 0      # 
anom_mag_moment_proton::Float64      = 0      # μ_p/μ_N - 1
anom_mag_moment_deuteron::Float64    = 0      # μ_{deuteron}/μ_N - 1
anom_mag_moment_neutron::Float64     = 0      # μ_{neutron}/μ_N - 1
anom_mag_moment_He3::Float64         = 0      # μ_{He3}/μ_N - 2


# these are global constants: they're unitless and thus the values won't change.
kg_per_amu::Float64                  = 1.66053906660e-27               # kg per standard atomic mass unit (dalton)
eV_per_amu::Float64                  = 9.3149410242e8                  # eV per standard atomic mass unit (dalton)
N_avogadro::Float64                  = 6.02214076e23                   # Number / mole  (exact)
fine_structure::Float64              = 7.2973525693e-3                 # fine structure constant


# values calculated from other constants in this collection



classical_radius_factor = r_e * m_electron                 # e^2 / (4 pi eps_0) [m*eV]
                                                #  = classical_radius * mass * c^2. 
                                                # Is same for all particles of charge +/- 1.
r_p                     = r_e * m_electron / m_proton      # proton radius [m] 
h_bar_planck            = h_planck / 2pi                   # h_planck/twopi [eV*sec]
kg_per_eV               = kg_per_amu / eV_per_amu



# constants mysteriously missing from the CODATA release

m_pion_0::Float64                = 134.9766e6                       # Mass [eV]/c^2
m_pion_charged::Float64          = 139.57018e6                      # Mass [eV]/c^2

 #---------------------------------------------------------------------------------------------------

export m_electron, m_proton, m_neutron, m_muon, m_helion, m_pion_0, m_pion_charged, m_deuteron, atomic_mass_unit
export c_light, e_charge, h_planck, h_bar_planck, r_e, r_p, mu_0_vac, eps_0_vac, classical_radius_factor, N_avogadro
export fine_structure_constant, anom_mag_moment_electron, anom_mag_moment_proton, anom_mag_moment_muon
export anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3
export kg_per_amu, eV_per_amu


