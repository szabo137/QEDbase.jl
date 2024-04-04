

struct LorentzVector{T}
    "`t` component"
    t::T

    "`x` component"
    x::T

    "`y` component"
    y::T

    "`z` component"
    z::T
end

+(lv::LorentzVector) = lv
function +(lv1::LorentzVector,lv2::LorentzVector) 
    t = lv1.x + lv2.t
    x = lv1.x + lv2.x
    y = lv1.y + lv2.y
    z = lv1.z + lv2.z
    return LorentzVector(t,x,y,z)
end

-(lv::LorentzVector) = LorentzVector(-lv.t,-lv.x,-lv.y,-lv.z)
function -(lv1::LorentzVector,lv2::LorentzVector) 
    t = lv1.x - lv2.t
    x = lv1.x - lv2.x
    y = lv1.y - lv2.y
    z = lv1.z - lv2.z
    return LorentzVector(t,x,y,z)
end

function *(a,lv::LorentzVector)
    return LorentzVector(a*lv.t,a*lv.x,a*lv.y,a*lv.z)
end

function *(lv::LorentzVector,a)
    return LorentzVector(lv.t*a,lv.x*a,lv.y*a,lv.z*a)
end

function /(lv::LorentzVector,a)
    return LorentzVector(lv.t/a,lv.x/a,lv.y/a,lv.z/a)
end
