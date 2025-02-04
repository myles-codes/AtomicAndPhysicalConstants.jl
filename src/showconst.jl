
function showconst(query::Symbol)
    # list all the physical constants and their values
    if (query == :constants || query == :physical)
        for (key, dict) in CODATA_Consts
            for (_, value) in dict
                println("- $key : $value")
            end
        end
        return
    end
    # list all the subatomic species
    if (query == :subatomic)
        for (key, _) in SUBATOMIC_SPECIES
            println("- $key")
        end
        return
    end
    # list all the atomic species
    if (query == :atomic)
        for (key, _) in ATOMIC_SPECIES
            println("- $key")
        end
        return
    end
    if (haskey(ATOMIC_SPECIES, string(query)))
        #the dictionary that stores all the isotopes
        dict = ATOMIC_SPECIES[string(query)].mass
        #sort the dictionary with isotopes mass number 
        sorted_dict = sort(collect(dict))
        for (key, value) in sorted_dict
            if key == -1
                println("- Average mass: $value")
            else
                println("- $query-$key : $value")
            end
        end
    else
        error("$query is not an available option")
    end
    return
end