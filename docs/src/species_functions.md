# Species Functions

Species functions each take a `Species` as their parameter and return a specific property. Here are the available functions:

- `massof(::Species)`
- `chargeof(::Species)`
- `atomicnumber(::Species)`
- `fullname(::Species)`
- `g_spin(::Species)`
    - ``g_spin = 2 m mu / S q`` is gyromagnetic ratio with:
    - ``m`` is species mass
    - ``mu`` is the species magnetic moment
    - ``S`` is the species spin
    - ``q`` is the species charge
- `gyromagnetic_anomaly(::Species)`
    - ``gyromagnetic_anomaly = (g-2)/2`` is the gyromagnetic anomaly with:
    - ``g`` is the gyromagnetic ratio
- `g_nucleon(::Species)`
    - ``g_nucleon = g Z m_p / m`` is the gyromagnetic anomaly for a baryon with:
    - ``g`` is the gyromagnetic ratio
    - ``Z`` is the species charge
    - ``m_p`` is the mass of a proton
    - ``m`` is species mass

**Note**: You must call `@APCdef` before using `massof()` or `chargeof()`.
