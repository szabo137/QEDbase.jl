# Refactoring Lorentz interface

## General TODO
- [ ] think about registry mechanism
- [ ] think about setter
- [ ] think about Minkowski dot 
- [ ] adjust tests
- [ ] implement `available_coordinate_systems`, which returns all subtypes of
`AbstactCoordianteSystem`

## Refactoring of Lorentz vectors
- [ ] implement generic lorentz vectors with arbitrary element type
- [ ] think about aritmetic for arbitrary element types, e.g. `scalar{T1}*lv{T2} = lv{promote(T1,T2)}`.
- [ ] is a static Lorentz vector type necessary

## Refactoring of four-momentum
- [ ] adjust the four-momentum interface (new names and additional functions)
- [ ] implement simple generic four-momentum type with element type <: Real
(maybe subtype of the simple Lorentz vector)
- [ ] be aware of promotion rules, e.g. `dirac_matrix*mom = lv{DM}`
- [ ] is a static four-momentum really necessary?
- [ ] think about glueing the coordinate system to the momentum type,
e.g. `FourMomentum{EXYZ}` implements the EXYZ interface
