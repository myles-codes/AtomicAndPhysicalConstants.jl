"""
    showconst(
        query::Symbol = :constants
    )

## Description:
list available constants in the package

## parameters:
- `query`     -- type:`Symbol`, the type of constants you want to know about

## options:
- `:constants`      -- list all physical constants
- `:subatomic`      -- list all possible subatomic particles
- `:(atomic symbol)`-- list all isotopes of that atomic species, e.g. :Fe

"""
showconst

function showconst(query::Union{Symbol,String}=:constants)
  if isdefined(Main, :UNITS)
    if query isa String
        query = Symbol(query)
    end
    # list all the physical constants and their values
    if (query == :constants)

      # this vector contains the names of the constants in symbols
      constants::Vector{Symbol} = filter(x ->
              startswith(string(x), "__b_"), names(parentmodule(@__MODULE__).@__MODULE__, all=true))

      for sym in constants
        value = eval(sym) # the value of the constant
        name = string(sym) # the name of the field
        println("- $(name[5:end])")
        println("\t- base value: $value")
        if (occursin("_m_", name)) # if the variable is the mass of a particle
          speciesname = split(name, "_m_")[2]
          println("\t- access by: massof(\"$speciesname\")")
        elseif (occursin("_mu_", name) && !occursin("__b_mu_0_vac", name)) # if the variable is the magnetic moment of a particle
          speciesname = split(name, "_mu_")[2]
          println("\t- access by: Species(\"$speciesname\").moment")
        else #a physical constant
          constantname = uppercase(name[5:end])
          println("\t- access by: @APCdef; APC.$constantname")
        end
      end
      return
    end
    # list all the subatomic species
    if (query == :subatomic)
      for (key, _) in SUBATOMIC_SPECIES
        println("- Species(\"$key\")")
      end
      return
    end

    if (haskey(SUBATOMIC_SPECIES, string(query)))
      fields = fieldnames(SubatomicSpecies)
      particle = SUBATOMIC_SPECIES[string(query)]
      println("Particle: ",getfield(particle, fields[1]))
      println("charge = ", uconvert(Main.UNITS.charge, getfield(particle, fields[2])),", ")
      println("mass = ", uconvert(Main.UNITS.mass, getfield(particle, fields[3])),", ")
      println("magnetic moment = ", uconvert(Main.UNITS.length^2 * Main.UNITS.charge / Main.UNITS.time,getfield(particle, fields[4])),", ")
      println("spin = ", uconvert(Main.UNITS.action,getfield(particle, fields[5])))
      


    elseif (haskey(ATOMIC_SPECIES, string(query)))
      #the dictionary that stores all the isotopes
      dict = ATOMIC_SPECIES[string(query)].mass
      #sort the dictionary with isotopes mass number 
      sorted_dict = sort(collect(dict))
      for (key, value) in sorted_dict
        if key == -1
          newv = uconvert(Main.UNITS.mass, value)
          println("- Species(\"$query\") : $newv")
        else
          newv = uconvert(Main.UNITS.mass, value)
          println("- Species(\"#$key$query\") : $newv")
        end
      end
    else
        error("$query is not an available option")
    end
    return
  else
    error("You must run @APCdef before you can showconst()")
  end
end