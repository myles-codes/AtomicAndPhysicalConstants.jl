# AtomicAndPhysicalConstants

[![Build Status](https://github.com/DavidSagan/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/DavidSagan/AtomicAndPhysicalConstants.jl/actions/workflows/CI.yml?query=branch%3Amain)


Version 0.1.0 release notes and doc

Package contains a library of atomic and subatomic particles associated to their properties, 
as well as other physical constants relevant to simulations of particle dynamics.

Particle data is stored in mutable data types containing available data on degenerate degrees of freedom,
immutable types are provided to store particle choice for use in scale simulations.

Functions provided include 
setref: creates an immutable object from the particle choice
charge_per_mass: returns the value of mass/charge for a chosen particle