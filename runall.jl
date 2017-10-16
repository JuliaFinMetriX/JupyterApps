## run files from ./src directory of same level as original notebook
## files 
files = readdir(".")

currDir = pwd()
println(string("current working directory: ", currDir))

using Base.Test

macro no_error(ex)
    quote
        try
            $(esc(ex))
            true
        catch
            false
        end
    end
end


@testset "Run individual notebook files" begin
	for f in files
   	 println("--------------------")
	    println("Running $f...")
   	 println("--------------------")
	    @test @no_error include(string("test/", f))
	    ## include(f)
	end
end


