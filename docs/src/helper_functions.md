# Helper Functions

The package provides several helper functions for simplified data lookup.

## showconst()

The `showconst()` function displays all available constants in the package.

There are three options:

```julia
julia> showconst() 
#list all the physical constants created by @APCdef
julia> showconst(:subatomic) 
#list all possible subatomic particles
julia> showconst(:Fe) 
# ':Fe' can be replaced by any atomic symbols
# list all the available isotopes of that element
```