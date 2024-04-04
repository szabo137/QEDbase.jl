### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ e8398830-dfd7-11ee-3743-2bb019dc699c
begin
	import Pkg
	Pkg.activate(".")

	using QEDbase
end

# ╔═╡ 2800bf47-4464-470e-b576-4130c5e3743f


# ╔═╡ 7d864b18-c3f3-4e6b-98ff-84b7c28e33ac
begin

	function coordinate_system end
	
const FOURMOMENTUM_ACCESSOR_FUNCTIONS = (:energy,
    :px,
    :py,
    :pz,
    :magnitude2,
    :mag2,
    :magnitude,
    :mag,
    :invariant_mass2,
    :mass2,
    :invariant_mass,
    :mass,
    :boost_beta,
    :boost_gamma,
    :transverse_momentum2,
    :pt2,
    :perp2,
    :transverse_momentum,
    :pt,
    :perp,
    :transverse_mass2,
    :mt2,
    :transverse_mass,
    :mt,
    :rapidity,
    :polar_angle,
    :cos_theta,
    :azimuthal_angle,
    :cos_phi,
    :sin_phi,
    :plus_component,
    :minus_component
)

for func in FOURMOMENTUM_ACCESSOR_FUNCTIONS
    eval(quote
		($func)(mom) = ($func)($coordinate_system(mom),mom)
    end)
end

end

# ╔═╡ 8d2901f9-7b99-4fd6-8e90-a1cbe6db1ac4
begin

	abstract type AbstractCoordinateSystem end
	struct EXYZ <: AbstractCoordinateSystem end
	
	
	struct CustomMom
		E::Float64
		x::Float64
		y::Float64
		z::Float64
	end
	coordinate_system(::CustomMom) = EXYZ()

	energy(::EXYZ,mom::CustomMom) = mom.E
	px(::EXYZ,mom::CustomMom) = mom.x
	py(::EXYZ,mom::CustomMom) = mom.y
	pz(::EXYZ,mom::CustomMom) = mom.z
end

# ╔═╡ 955bee2d-33d8-428f-9aa4-742010954114


# ╔═╡ fbe60c01-32d6-4110-baf9-bfc92a6a17f0
mom = CustomMom(1,2,3,4)

# ╔═╡ b5cf4fab-2b88-40af-844e-c2f82531a50b
energy(mom)

# ╔═╡ 18d65036-f6fb-4fab-883c-e5e8c448e0aa
px(mom)

# ╔═╡ Cell order:
# ╠═e8398830-dfd7-11ee-3743-2bb019dc699c
# ╠═2800bf47-4464-470e-b576-4130c5e3743f
# ╠═7d864b18-c3f3-4e6b-98ff-84b7c28e33ac
# ╠═8d2901f9-7b99-4fd6-8e90-a1cbe6db1ac4
# ╠═955bee2d-33d8-428f-9aa4-742010954114
# ╠═fbe60c01-32d6-4110-baf9-bfc92a6a17f0
# ╠═b5cf4fab-2b88-40af-844e-c2f82531a50b
# ╠═18d65036-f6fb-4fab-883c-e5e8c448e0aa
