using QEDbase

struct TestCoordinteSystem <: QEDbase.AbstractCoordinateSystem end
QEDbase.coordinate_names(::TestCoordinteSystem)= (:a,:b,:c,:d)

for (fun_idx,fun) in enumerate(QEDbase.FOURMOMENTUM_GETTER_FUNCTIONS)
    eval(
        quote
            ($QEDbase.$fun)(::$TestCoordinteSystem,mom) = $fun_idx
        end
    )
end

struct TestMomentum end

QEDbase.coordinate_system(::TestMomentum) = TestCoordinteSystem()

@testset "Accessor functions" begin
    mom = TestMomentum()
    for (i,fun) in enumerate(QEDbase.FOURMOMENTUM_GETTER_FUNCTIONS)
        @test eval(fun)(mom) == i 
    end
end

@testset "Aliasses" begin
    mom = TestMomentum()
    for (alias,fun) in QEDbase.FOURMOMENTUM_GETTER_ALIASSES
        @test eval(alias)(mom) == eval(fun)(mom) 
    end
end
