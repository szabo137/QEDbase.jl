module QEDbase

using SimpleTraits
using ArgCheck
using ConstructionBase

import Base: *
import StaticArrays: similar_type

export minkowski_dot, mdot
export energy, px, py, pz 
export magnitude2, mag2, magnitude, mag
export invariant_mass2, mass2, invariant_mass, mass
export boost_beta, boost_gamma
export transverse_momentum2, pt2, perp2
export transverse_momentum, pt, perp 
export transverse_mass2,mt2, transverse_mass, mt
export rapidity, pseudorapidity
export polar_angle, cos_theta, azimuthal_angle, cos_phi, sin_phi
export plus_component, minus_component
#
# export setE!, setEnergy!, setPx!, setPy!, setPz!
# export setTheta!, setCosTheta!, setRho!, setPhi!
# export setPlus!, setMinus!
# export setTransverseMomentum!, setPerp!, setPt!
# export setTransverseMass!, setMt!
# export setRapidity!
export coordinate_system, coordinate_names
# export AbstractLorentzVector, SLorentzVector, MLorentzVector, dot
# export SFourMomentum, MFourMomentum, isonshell, assert_onshell

export AbstractLorentzVector, SLorentzVector, dot
export SFourMomentum,isonshell, assert_onshell

export BiSpinor, AdjointBiSpinor, DiracMatrix, mul
export AbstractDiracVector, AbstractDiracMatrix

export gamma, GAMMA, AbstractGammaRepresentation, DiracGammaRepresentation, slashed

export BASE_PARTICLE_SPINOR, BASE_ANTIPARTICLE_SPINOR
export IncomingFermionSpinor,
    OutgoingFermionSpinor, IncomingAntiFermionSpinor, OutgoingAntiFermionSpinor
export SpinorU, SpinorUbar, SpinorV, SpinorVbar
export @valid_spinor_input

# particle interface
export AbstractParticle
export is_fermion, is_boson, is_particle, is_anti_particle
export base_state
export mass, charge

# particle types
export AbstractParticleType
export FermionLike, Fermion, AntiFermion, MajoranaFermion
export BosonLike, Boson, AntiBoson, MajoranaBoson
export Electron, Positron, Photon
export ParticleDirection, Incoming, Outgoing

# polarizations and spins
export AbstractSpinOrPolarization, AbstractPolarization, AbstractSpin
export AbstractDefinitePolarization, AbstractIndefinitePolarization
export PolarizationX, PolX, PolarizationY, PolY, AllPolarization, AllPol
export AbstractDefiniteSpin, AbstractIndefiniteSpin
export SpinUp, SpinDown, AllSpin

using StaticArrays
using LinearAlgebra
using DocStringExtensions

include("interfaces/four_momentum_interface.jl")
include("coordinate_systems/exyz.jl")

include("dirac_tensors.jl")
include("lorentz_vector.jl")
include("gamma_matrices.jl")

include("four_momentum.jl") # maybe go to a kinematics module!!

include("interfaces/particle_interface.jl")
include("particles/particle_types.jl")
include("particles/particle_direction.jl")
include("particles/particle_spin_pol.jl")
include("particles/particle_spinors.jl")
include("particles/particle_states.jl")

end #QEDbase
