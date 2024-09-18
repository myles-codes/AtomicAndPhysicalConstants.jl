# AtomicAndPhysicalConstants/src/PhysicalConstants.jl

# this first group of constants are available in the ascii sheet

# 2018 CODATA



__b_m_electron = 0.51099895000e6;                 # Electron Mass [eV]/c^2
__b_m_proton = 0.93827208816e9;                 # Proton Mass [eV]/c^2
__b_m_neutron = 0.93956542052e9;                 # Neutron Mass [eV]/c^2
__b_m_muon = 105.6583755e6;                   # Muon Mass [eV]
__b_m_helion = 2.808391607035771e9;             # Helion Mass He3 nucleus [eV]/c^2
__b_m_deuteron = 1.87561294257e9;                 # Deuteron Mass [eV]/c^2
__b_c_light = 2.99792458e8;                    # speed of light [m/s]
__b_h_planck = 4.135667696e-15;                 # Planck's constant [eV*s]
__b_r_e = 2.8179403262e-15;                # classical electron radius [m]
__b_mu_0_vac = 1.25663706212e-6;                # Vacuum permeability in [N/A^2] (newtons per ampere squared)
__b_eps_0_vac = 1 / (__b_c_light^2 * __b_mu_0_vac);      # Permittivity of free space in [F/m]

__b_e_charge = 1.602176634e-19;                 # elementary charge [Coul]
__b_fine_structure = 7.2973525693e-3;                 # fine structure constant
__b_gyromagnetic_anomaly_electron = 1.15965218128e-3;                # anomalous mag. mom. of the electron (unitless)
__b_gyromagnetic_anomaly_muon = 1.16592089e-3;                   # ~fine_structure_ant / twopi
__b_gyromagnetic_anomaly_proton = 1.79284734463e0;                 # μ_p/μ_N - 1
__b_gyromagnetic_anomaly_deuteron = -0.14298726925e0;                # μ_{deuteron}/μ_N - 1
__b_gyromagnetic_anomaly_neutron = -1.91304273e0;                   # μ_{neutron}/μ_N - 1
__b_gyromagnetic_anomaly_He3 = -4.184153686e0;                  # μ_{He3}/μ_N - 2
__b_kg_per_amu = 1.66053906660e-27;               # kg per standard atomic mass unit (dalton)
__b_eV_per_amu = 9.3149410242e8;                  # eV per standard atomic mass unit (dalton)
__b_N_avogadro = 6.02214076e23;                   # Number / mole  (exact)



__b_mu_deuteron = 0;
__b_mu_electron = 0;
__b_mu_helion = 0;
__b_mu_muon = 0;
__b_mu_neutron = 0;
__b_mu_proton = 0;
__b_mu_triton = 0;
# values calculated from other constants in this collection



__b_classical_radius_factor = __b_r_e * __b_m_electron;                 # e^2 / (4 pi eps_0) [m*eV]
#  = classical_radius * mass * c^2. 
# Is same for all particles of charge +/- 1.
__b_r_p = __b_r_e * __b_m_electron / __b_m_proton;      # proton radius [m] 
__b_h_bar_planck = __b_h_planck / 2pi;                   # h_planck/twopi [eV*sec]




# constants mysteriously missing from the CODATA release

__b_m_pion_0 = 134.9766e6;                      # Mass [eV]/c^2
__b_m_pion_charged = 139.57018e6;                     # Mass [eV]/c^2

#---------------------------------------------------------------------------------------------------




