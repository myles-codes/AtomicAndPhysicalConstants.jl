
# Constants 

Constants are accessed by a getter function. If a unit is provided, then the value with that unit is returned. If units is not provided, then the units will be in the units determined by `setunits()`. For Example:

```julia
c_light(u"km/s") # return 299792.458 km s⁻¹

setunits() # set units to ACCELERATOR unit system, where speed unit is m/s

c_light() #return 2.99792458e8 m s⁻¹
```

## Here is a list of constants getter functions:

#### Speed of light: `c_light()`
#### Planck's constant: `h_planck()`
#### Reduced Planck's constant: `h_bar_planck()`
#### Classical electron radius: `r_e()`
#### Classical proton radius: `r_p()`
#### Elementary charge:  `e_charge()`
#### Vacuum permeability: `mu_0_vac()`
#### Permittivity of free space: `eps_0_vac()`
#### Classical Radius Factor: `classical_radius_factor()`
#### Fine structure constant: `fine_structure()`
#### Avogadro's constant: `N_avogadro()`

## Species Mass and Charge

To access mass or charge of a species, use `massof()` getter function for mass, and `chargeof()` getter function for charge. Similarly, if a unit is not provided, the function will return unit defined by `setunits()`. For Example:

```julia
e = Species("electron") 

setunits() # set units to ACCELERATOR unit system, where mass unit is eV/c^2 and charge unit is elementary charge

massof(e) # return 510998.95069 eV c⁻²

massof(e,u"MeV/c^2") # return 0.51099895069 MeV c⁻²

chargeof(e) # return -1.0 e

chargeof(e, u"C") #return -1.602176634e-19 C
```

### Here is a list of species where you can find its mass or charge in a similar way

  - "pion0"
  - "neutron"
  - "deuteron"
  - "pion+"
  - "proton"
  - "photon"
  - "electron" 
  - "anti-proton"
  - "muon"
  - "pion-"
  - "anti-deuteron"