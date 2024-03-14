# AtomicAndPhysicalConstants

[![Build Status](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/bmad-sim/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml?query=branch%3Amain)


Version 0.1.0 release notes and doc

Package contains a library of atomic and subatomic particles associated to their properties, 
as well as other physical constants relevant to simulations of particle dynamics.

PhysicalConstants.jl 
is a set of constant floats corresponding to physical constants, ranging 
from the speed of light and Planck's constant to 'fundamental' particle masses. These constants 
are kept as isolated named constants rather than in a dictionary for ease of access throughout 
the rest of this and other packages.

ParticleTypes.jl 
defines particle species types for managing information. 
It defines 'SubatomicSpecies,' 'AtomicSpecies,' and 'MolecularSpecies:' 
immutable structs to hold specific reference particle info for use in simulation or computation.
Following are mutable structs 'SubatomicSpeciesData,' and 'AtomicSpeciesData,' which hold
all the available information about the particle in question, including degeneracies.

AtomicSpecies.jl
contains a dictionary of 118 atomic elements and all of their known isotopes, along with 
the 'isotopic average'
The dictionary is keyed with atomic symbols as strings, *eg* "He", and has 
'AtomicSpeciesData' structs as values

SubatomicSpecies.jl
contains a dictionary of the subatomic particles accessible with this package
The dictionary is keyed with the name of the particle as a string, *eg* "pion0", "proton", or "anti_neutron",
and has 'SubatomicSpeciesData' structs as values

ParticleFunctions.jl
functions to be performed on a ---SpeciesData or AbstractSpecies struct.
setref takes in a mutable struct and other parameters and returns an immutable reference particle
charge_per_mass takes in a particle and returns the ratio charge/mass

UpdateCODATA.jl
updates the values in PhysicalConstants.jl with the data from a specified CODATA release
There are some values it doesn't get, namely the pion masses and a few anomalous magnetic momenta
Currently, it doesn't overwrite PhysicalConstants.jl but writes a new file yyyy-mm-dd_Constants.jl,
where yyyy-mm-dd is 'today's' date

UpdateIsoMasses.jl
updates the properties of the atoms in AtomicSpecies.jl: it grabs the linearized list of every 
isotope of every element from the NIST database and writes out a new file called yyyy-mm-dd_AtomicSpecies.jl

UpdatePionMass.jl
defines a function download_pdg_pion_mass thet gets the mass of charged and uncharged pions from the PDG and 
returns a vector [mass_of_pi0, mass_of_pi+-]
this function will be integrated into the update of physical constants

AtomicAndPhysicalConstants.jl
imports all of the above files and defines a module with all of the functionality
