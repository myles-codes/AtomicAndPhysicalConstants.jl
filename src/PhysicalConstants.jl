# AtomicAndPhysicalConstants/src/PhysicalConstants.jl

# this first group of constants are available in the ascii sheet

# 2018 CODATA

m_electron                  = 0.51099895000e6                 # Electron Mass [eV]/c^2
m_proton                    = 0.93827208816e9                 # Proton Mass [eV]/c^2
m_neutron                   = 0.93956542052e9                 # Neutron Mass [eV]/c^2
m_muon                      = 105.6583755e6                   # Muon Mass [eV]
m_helion                    = 2.808391607035771e9             # Helion Mass He3 nucleus [eV]/c^2
m_deuteron                  = 1.87561294257e9                 # Deuteron Mass [eV]/c^2
c_light                     = 2.99792458e8                    # speed of light [m/s]
h_planck                    = 4.135667696e-15                 # Planck's constant [eV*s]
r_e                         = 2.8179403262e-15                # classical electron radius [m]
mu_0_vac                    = 1.25663706212e-6                # Vacuum permeability in [N/A^2] (newtons per ampere squared)
eps_0_vac                   = 1 / (c_light^2 * mu_0_vac)      # Permittivity of free space in [F/m]
N_avogadro                  = 6.02214076e23                   # Number / mole  (exact)
e_charge                    = 1.602176634e-19                 # elementary charge [Coul]
fine_structure              = 7.2973525693e-3                 # fine structure constant
anom_mag_moment_electron    = 1.15965218128e-3                # anomalous mag. mom. of the electron (unitless)
anom_mag_moment_muon        = 1.16592089e-3                   # ~fine_structure_ant / twopi
anom_mag_moment_proton      = 1.79284734463e0                 # μ_p/μ_N - 1
anom_mag_moment_deuteron    = -0.14298726925e0                # μ_{deuteron}/μ_N - 1
anom_mag_moment_neutron     = -1.91304273e0                   # μ_{neutron}/μ_N - 1
anom_mag_moment_He3         = -4.184153686e0                  # μ_{He3}/μ_N - 2
kg_per_amu                  = 1.66053906660e-27               # kg per standard atomic mass unit (dalton)
eV_per_amu                  = 9.3149410242e8                  # eV per standard atomic mass unit (dalton)

# values calculated from other constants in this collection



classical_radius_factor = r_e * m_electron                 # e^2 / (4 pi eps_0) [m*eV]
                                                #  = classical_radius * mass * c^2. 
                                                # Is same for all particles of charge +/- 1.
r_p                     = r_e * m_electron / m_proton      # proton radius [m] 
h_bar_planck            = h_planck / 2pi                   # h_planck/twopi [eV*sec]
kg_per_eV               = kg_per_amu / eV_per_amu



# constants mysteriously missing from the CODATA release

m_pion_0                = 134.9766e6                       # Mass [eV]/c^2
m_pion_charged          = 139.57018e6                      # Mass [eV]/c^2

 #---------------------------------------------------------------------------------------------------

export m_electron, m_proton, m_neutron, m_muon, m_helion, m_pion_0, m_pion_charged, m_deuteron, atomic_mass_unit
export c_light, e_charge, h_planck, h_bar_planck, r_e, r_p, mu_0_vac, eps_0_vac, classical_radius_factor, N_avogadro
export fine_structure_constant, anom_mag_moment_electron, anom_mag_moment_proton, anom_mag_moment_muon
export anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3
export kg_per_amu, eV_per_amu


