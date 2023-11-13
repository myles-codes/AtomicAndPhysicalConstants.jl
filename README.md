# AtomicAndPhysicalConstants

[![Build Status](https://github.com/DavidSagan/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/DavidSagan/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml?query=branch%3Amain)


Version 0.1.0 release notes and doc

Package contains a library of atomic and subatomic particles associated to their properties, 
as well as other physical constants relevant to simulations of particle dynamics.

PhysicalConstants.jl 
is a set of constant floats corresponding to physical constants, ranging 
from the speed of light and Planck's constant to 'fundamental' particle masses. These constants 
are kept as isolated named constants rather than in a dictionary for ease of access throughout 
the rest of this and other packages.

ParticleSpecies.jl 
defines particle species types and information. 
It defines 'SubatomicSpecies,' 'AtomicSpecies,' and 'MolecularSpecies:' 
immutable structs to hold specific reference particle info for use in simulation or computation.
Following are mutable structs 'SubatomicSpeciesData,' and 'AtomicSpeciesData,' which hold
all the available information about the particle in question, including degeneracies.
Finally there are dictionaries 'Subatomic_Particles' and 'Atomic_Particles' which connect 
the mutable structs holding particle data to the names of the particles.

ParticleFunctions.jl
functions to be performed on an SpeciesData or AbstractSpecies struct.
setref takes in a mutable struct and other parameters and returns an immutable reference particle
charge_per_mass takes in a particle and returns the ratio charge/mass

AtomicAndPhysicalConstants.jl
imports all of the above files and defines a module with all of the functionality