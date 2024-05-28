# AtomicAndPhysicalConstants

[![Build Status](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml?query=branch%3Amain)




AtomicAndPhysicalConstants is a package which provides numerical constants and 
simulation-ready objects for tracking through an accelerator lattice, as well as 
other possible scenarios. It includes information about a number of hadrons and 
fundamental particles, listed below; also included is detailed information about 
every isotope of every atomic element documented by NIST. 

The list of numerical constants included is:
c_light: speed of light,
h_planck: planck's constant (energy),
h_bar_planck: \hbar, planck's constant (angular momentum),
mu_0_vac: vacuum permeability,
eps_0_vac: vacuum permittivity,
fine_structure: fine structure constant,
N_avogadro: Avogadro's constant,
m_electron: electron mass,
r_e: electron radius,
anom_mag_moment_electron: anomalous magnetic moment of the electron,
m_proton: proton mass,
r_p: proton radius,
anom_mag_moment_proton: anomalous magnetic moment of the proton,
m_neutron: neutron mass,
anom_mag_moment_neutron: anomalous magnetic moment of the neutron,
m_muon: muon mass,
anom_mag_moment_muon: anomalous magnetic moment of the muon, 
m_helion: Helion (He3 nucleus) mass,
anom_mag_moment_He3: anomalous magnetic moment of the helion,
m_deuteron: deuteron mass,
anom_mag_moment_deuteron: anomalous magnetic moment of the deuteron,
m_pion_0: mass of a neutral pion,
m_pion_charged: mass of a charged pion,
kg_per_amu: mass conversion factor between kg and dalton,
eV_per_amu: mass conversion factor between eV/c^2 and dalton.


Subatomic particles included with information about 
charge, mass, anomalous magnetic moment, and spin
are:
photon,
neutral pion,
charged pion (+/-),
muon,
antimuon,
electron,
positron,
proton,
anti-proton,
neutron,
anti-neutron,
deuteron,
anti-deuteron


In addition, a collection of all the isotopes documented by NIST
is included: it may be updated with setIsos()
