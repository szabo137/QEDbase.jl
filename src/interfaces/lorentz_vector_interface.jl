"""
  
  comp_x(::AbstractCoordinateSystem,lorentz_vector)

TBW
"""
function comp_x end

"""
  
  comp_y(::AbstractCoordinateSystem,lorentz_vector)

TBW
"""
function comp_y end

"""
  
  comp_z(::AbstractCoordinateSystem,lorentz_vector)

TBW
"""
function comp_z end

"""
  
  comp_t(::AbstractCoordinateSystem,lorentz_vector)

TBW
"""
function comp_t end


#=
comp_x(lorentz_vec) = comp_x(coordinate_system(lorentz_vec),lorentz_vec)
comp_y(lorentz_vec) = comp_y(coordinate_system(lorentz_vec),lorentz_vec)
comp_z(lorentz_vec) = comp_z(coordinate_system(lorentz_vec),lorentz_vec)
comp_t(lorentz_vec) = comp_t(coordinate_system(lorentz_vec),lorentz_vec)
=#

# generic implementations if lorentz_vec is a four-momentum
#=
comp_x(cs::AbstractCoordinateSystem,lorentz_vec) = px(cs,lorentz_vec)
comp_y(cs::AbstractCoordinateSystem,lorentz_vec) = py(cs,lorentz_vec)
comp_z(cs::AbstractCoordinateSystem,lorentz_vec) = pz(cs,lorentz_vec)
comp_t(cs::AbstractCoordinateSystem,lorentz_vec) = energy(cs,lorentz_vec)
=#

comp_x(lorentz_vec) = px(lorentz_vec)
comp_y(lorentz_vec) = py(lorentz_vec)
comp_z(lorentz_vec) = pz(lorentz_vec)
comp_t(lorentz_vec) = energy(lorentz_vec)
