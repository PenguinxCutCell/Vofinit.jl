using Documenter
using Vofinit

makedocs(
    modules = [Vofinit],
    authors = "PenguinxCutCell and contributors",
    repo = "https://github.com/PenguinxCutCell/Vofinit.jl/blob/{commit}{path}#{line}",
    sitename = "Vofinit.jl",
    format = Documenter.HTML(
        canonical = "https://PenguinxCutCell.github.io/Vofinit.jl",
        repolink = "https://github.com/PenguinxCutCell/Vofinit.jl",
        collapselevel = 2,
    ),
    pages = [
        "Home" => "index.md",
        "Reference" => "95-reference.md",
    ],
    pagesonly = true,
    warnonly = true,
)

deploydocs(
    repo = "github.com/PenguinxCutCell/Vofinit.jl",
    push_preview = true,
)
