# overrides.jl

#####################################################################
# In the following code, standard base.getproperty functions are 
# overridden
#####################################################################

import Base: getproperty

"""
This definition overrides Base.getproperty to disallow access to 
the Species fields :mass and :charge via the dot syntax, i.e. 
Species.mass or Species.charge"
"""
getproperty

function getproperty(obj::Species, field::Symbol)
  if field == :mass || field == :charge
    error("Do not use the 'base.getproperty' syntax to access fields 
    of Species objects: instead use the provided functions; massof,
    and chargeof.")
  end
end; export getproperty