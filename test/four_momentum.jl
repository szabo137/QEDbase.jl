using QEDbase
using Random

const ATOL = 1e-15

@testset "FourMomentum getter" for MomentumType in [SFourMomentum, ]
    rng = MersenneTwister(12345)
    x, y, z = rand(rng, 3)
    mass_val = rand(rng)
    E = sqrt(x^2 + y^2 + z^2 + mass_val^2)
    mom_onshell = MomentumType(E, x, y, z)
    mom_zero = MomentumType(0.0, 0.0, 0.0, 0.0)
    mom_offshell = MomentumType(0.0, 0.0, 0.0, mass_val)

    @testset "magnitude consistence" for mom in [mom_onshell, mom_offshell, mom_zero]
        @test magnitude2(mom) == mag2(mom)
        @test magnitude(mom) == mag(mom)
        @test isapprox(magnitude(mom), sqrt(magnitude2(mom)))
    end

    @testset "magnitude values" begin
        @test isapprox(magnitude2(mom_onshell), x^2 + y^2 + z^2)
        @test isapprox(magnitude(mom_onshell), sqrt(x^2 + y^2 + z^2))
    end

    @testset "mass consistence" for mom_on in [mom_onshell, mom_zero]
        @test invariant_mass2(mom_on) == mass2(mom_on)
        @test invariant_mass(mom_on) == mass(mom_on)
        @test isapprox(invariant_mass(mom_on), sqrt(invariant_mass2(mom_on)))
    end

    @testset "mass value" begin
        @test isapprox(invariant_mass2(mom_onshell), E^2 - (x^2 + y^2 + z^2))
        @test isapprox(invariant_mass(mom_onshell), sqrt(E^2 - (x^2 + y^2 + z^2)))

        @test isapprox(invariant_mass(mom_onshell), mass_val)
        @test isapprox(invariant_mass(mom_offshell), -mass_val)
        @test isapprox(invariant_mass(mom_zero), 0.0)
    end

    @testset "momentum components" begin
        @test energy(mom_onshell) == E
        @test px(mom_onshell) == x
        @test py(mom_onshell) == y
        @test pz(mom_onshell) == z

        @test isapprox(boost_beta(mom_onshell), sqrt(x^2 + y^2 + z^2) / E)
        @test isapprox(boost_gamma(mom_onshell), 1 / sqrt(1.0 - boost_beta(mom_onshell)^2))

        @test energy(mom_zero) == 0.0
        @test px(mom_zero) == 0.0
        @test py(mom_zero) == 0.0
        @test pz(mom_zero) == 0.0

        @test isapprox(boost_beta(mom_zero), 0.0)
        @test isapprox(boost_gamma(mom_zero), 1.0)
    end

    @testset "transverse coordinates" for mom_on in [mom_onshell, mom_zero]
        @test transverse_momentum2(mom_on) == pt2(mom_on)
        @test transverse_momentum2(mom_on) == perp2(mom_on)
        @test transverse_momentum(mom_on) == pt(mom_on)
        @test transverse_momentum(mom_on) == perp(mom_on)

        @test isapprox(transverse_momentum(mom_on), sqrt(transverse_momentum2(mom_on)))

        @test transverse_mass2(mom_on) == mt2(mom_on)
        @test transverse_mass(mom_on) == mt(mom_on)
    end

    @testset "transverse coordiantes value" begin
        @test isapprox(transverse_momentum2(mom_onshell), x^2 + y^2)
        @test isapprox(transverse_momentum(mom_onshell), sqrt(x^2 + y^2))
        @test isapprox(transverse_mass2(mom_onshell), E^2 - z^2)
        @test isapprox(transverse_mass(mom_onshell), sqrt(E^2 - z^2))
        @test isapprox(transverse_mass(mom_offshell), -mass_val)

        @test isapprox(rapidity(mom_onshell), 0.5 * log((E + z) / (E - z)))

        @test isapprox(transverse_momentum2(mom_zero), 0.0)
        @test isapprox(transverse_momentum(mom_zero), 0.0)
        @test isapprox(transverse_mass2(mom_zero), 0.0)
        @test isapprox(transverse_mass(mom_zero), 0.0)
    end

    @testset "spherical coordiantes consistence" for mom_on in [mom_onshell, mom_zero]
        @test isapprox(cos_theta(mom_on), cos(polar_angle(mom_on)))
        @test isapprox(cos_phi(mom_on), cos(azimuthal_angle(mom_on)))
        @test isapprox(sin_phi(mom_on), sin(azimuthal_angle(mom_on)))
    end

    @testset "spherical coordiantes values" begin
        @test isapprox(polar_angle(mom_onshell), atan(transverse_momentum(mom_onshell), z))
        @test isapprox(polar_angle(mom_zero), 0.0)

        @test isapprox(azimuthal_angle(mom_onshell), atan(y, x))
        @test isapprox(azimuthal_angle(mom_zero), 0.0)
    end

    @testset "light-cone coordiantes" begin
        @test isapprox(plus_component(mom_onshell), 0.5 * (E + z))
        @test isapprox(minus_component(mom_onshell), 0.5 * (E - z))

        @test isapprox(plus_component(mom_zero), 0.0)
        @test isapprox(minus_component(mom_zero), 0.0)
    end
end # FourMomentum getter
#=
function test_get_set(rng, setter, getter; value=rand(rng))
    x, y, z = rand(rng, 3)
    mass = rand(rng)
    E = sqrt(x^2 + y^2 + z^2 + mass^2)
    mom = MFourMomentum(E, x, y, z)
    setter(mom, value)
    return isapprox(getter(mom), value)
end

@testset "FourMomentum setter" begin
    rng = MersenneTwister(123456)

    @testset "Momentum components" begin
        @test test_get_set(rng, setE!, getE)
        @test test_get_set(rng, setEnergy!, getE)
        @test test_get_set(rng, setPx!, getPx)
        @test test_get_set(rng, setPy!, getPy)
        @test test_get_set(rng, setPz!, getPz)
    end

    @testset "spherical coordiantes" begin
        @test test_get_set(rng, setTheta!, getTheta)
        @test test_get_set(rng, setTheta!, getTheta, value=0.0)
        @test test_get_set(rng, setCosTheta!, getCosTheta)
        @test test_get_set(rng, setCosTheta!, getCosTheta, value=1.0)
        @test test_get_set(rng, setPhi!, getPhi)
        @test test_get_set(rng, setPhi!, getPhi, value=0.0)
        @test test_get_set(rng, setRho!, getRho)
        @test test_get_set(rng, setRho!, getRho, value=0.0)
    end

    @testset "light-cone coordiantes" begin
        @test test_get_set(rng, setPlus!, getPlus)
        @test test_get_set(rng, setPlus!, getPlus, value=0.0)
        @test test_get_set(rng, setMinus!, getMinus)
        @test test_get_set(rng, setMinus!, getMinus, value=0.0)
    end

    @testset "transverse coordinates" begin
        @test test_get_set(rng, setTransverseMomentum!, getTransverseMomentum)
        @test test_get_set(rng, setTransverseMomentum!, getTransverseMomentum, value=0.0)
        @test test_get_set(rng, setPerp!, getTransverseMomentum)
        @test test_get_set(rng, setPt!, getTransverseMomentum)
        @test test_get_set(rng, setTransverseMass!, getTransverseMass)
        @test test_get_set(rng, setTransverseMass!, getTransverseMass, value=0.0)
        @test test_get_set(rng, setMt!, getTransverseMass)
        @test test_get_set(rng, setRapidity!, getRapidity)
        @test test_get_set(rng, setRapidity!, getRapidity, value=0.0)
    end
end # FourMomentum setter
=#

const SCALE = 10.0 .^ [-9, 0, 5]
const M_MASSIVE = 1.0
const M_MASSLESS = 0.0

const M_ABSERR = 0.01
const M_RELERR = 0.0001

@testset "isonshell" begin
    rng = MersenneTwister(42)
    x_base, y_base, z_base = rand(rng, 3)

    @testset "correct onshell" begin
        @testset "($x_scale, $y_scale, $z_scale)" for (x_scale, y_scale, z_scale) in
                                                      Iterators.product(SCALE, SCALE, SCALE)
            x, y, z = x_base * x_scale, y_base * y_scale, z_base * z_scale
            E_massless = sqrt(x^2 + y^2 + z^2 + M_MASSLESS^2)
            E_massive = sqrt(x^2 + y^2 + z^2 + M_MASSIVE^2)
            mom_massless = SFourMomentum(E_massless, x, y, z)
            mom_massive = SFourMomentum(E_massive, x, y, z)
            @test isonshell(mom_massless, M_MASSLESS)
            @test isonshell(mom_massive, M_MASSIVE)

            @test assert_onshell(mom_massless, M_MASSLESS) == nothing
            @test assert_onshell(mom_massive, M_MASSIVE) == nothing
        end
    end

    @testset "correct not onshell" begin
        @testset "$x_scale, $y_scale, $z_scale" for (x_scale, y_scale, z_scale) in
                                                    Iterators.product(SCALE, SCALE, SCALE)
            x, y, z = x_base * x_scale, y_base * y_scale, z_base * z_scale
            m_err = min(M_ABSERR, M_RELERR * sum([x, y, z]) / 3.0) # mass error is M_RELERR of the mean of the components
            # but has at most the value M_ABSERR

            E_massless = sqrt(x^2 + y^2 + z^2 + (M_MASSLESS + m_err)^2)
            E_massive = sqrt(x^2 + y^2 + z^2 + (M_MASSIVE + m_err)^2)
            mom_massless = SFourMomentum(E_massless, x, y, z)
            mom_massive = SFourMomentum(E_massive, x, y, z)

            @test !isonshell(mom_massless, M_MASSLESS)
            @test !isonshell(mom_massive, M_MASSIVE)

            @test_throws QEDbase.OnshellError assert_onshell(mom_massless, M_MASSLESS)
            @test_throws QEDbase.OnshellError assert_onshell(mom_massive, M_MASSIVE)
        end
    end
end
