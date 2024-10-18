
# Physical Constants

Here is a list of constants provided in the package.
The units of the constants are determined by `setunits()`.
Constants are pulled from the NIST table of the **2022 CODATA release**. Note that `m_pion_0` and `m_pion_charged` are pulled from **PDG**.

## Physical Constants
#### Speed of light: `c_light`
#### Planck's constant: `h_planck`
#### Classical electron radius: `r_e`
#### Vacuum permeability: `mu_0_vac`
#### Elementary charge:  `e_charge`
#### Avogadro's constant: `N_avogadro`
#### Fine structure constant: `fine_structure`

## Species Mass
#### Electron Mass: `m_electron`
#### Proton Mass: `m_proton`
#### Neutron Mass: `m_neutron`
#### Muon Mass: `m_muon`
#### Helion Mass He3 nucleus: `m_helion`
#### Deuteron Mass: `m_deuteron`
#### uncharged pion mass: `m_pion_0`
#### charged pion mass: `m_pion_charged`

## Species Magnetic Momoments
#### Deuteron magnetic moment: `mu_deuteron`
#### Electron magnetic moment: `mu_electron`
#### Helion magnetic moment: `mu_helion`
#### Muon magnetic moment: `mu_muon`
#### Neutron magnetic moment: `mu_neutron`
#### Proton magnetic moment: `mu_proton`
#### Triton magnetic moment: `mu_triton`


## Conversion Factors
#### kg per standard atomic mass unit: `kg_per_amu`
#### eV per standard atomic mass unit: `eV_per_amu`
#### Joules per eV: `J_per_eV`


# values calculated from other constants in this collection

classical_radius_factor = __b_r_e * __b_m_electron;
# e^2 / (4 pi eps_0) = classical_radius * mass * c^2.
# Is same for all particles of charge +/- 1.
r_p = __b_r_e * __b_m_electron / __b_m_proton;
# proton radius [m]
h_bar_planck = __b_h_planck / 2pi;
# h_planck/twopi [eV*s]
eps_0_vac = 8.8541878188e-12 * u"F/m"
# Permittivity of free space in [F/m]








