#*****************************************************************************#
# Author: 	John Joseph Valletta
# Date: 	02/03/2018
# Title: 	Convert R Markdown to Markdown for use with Jekyll blog
# Assumed folder structure:
# _rmd: NNN-my-blog.Rmd
# assets/img/my-blog: images associated with my-blog
# _posts: auto-generated YY-MM-DD-NNN-my-blog.md (references figures in assets/img/my-blog)
#
# Resources:
# http://www.jonzelner.net/jekyll/knitr/r/2014/07/02/autogen-knitr/
# https://rgriff23.github.io/2017/04/25/how-to-knit-for-mysite.html
# http://andysouth.github.io/blog-setup/
# http://brooksandrew.github.io/simpleblog/articles/blogging-with-r-markdown-and-jekyll-using-knitr/
# http://tinyheero.github.io/2015/12/06/rmd-to-jekyll-protect-eqn.html
#*****************************************************************************#
knit_post <- function(fileName, baseDir=getwd())
{
    # Load required libraries
    require(knitr, quietly=TRUE, warn.conflicts=FALSE)
    
    # Initialise paths (e.g 000-test-blog.Rmd)
    # Input/output path (append YYYY-MM-DD as Jekyll requires to output path)
    inPath <- file.path(baseDir, "_rmd", fileName)
    outPath <- file.path(baseDir, "_posts", sub(".Rmd$", ".md", paste0(Sys.Date(), "-", fileName)))
    # Figure path
    title <- unlist(strsplit(fileName, "\\."))[1] # remove .Rmd
    figDir <- file.path("assets", "img", paste0(title, "/")) 
    dir.create(file.path(baseDir, figDir)) # create 000-test-blog/ to save figs
    
    # Set knitr paths
    opts_knit$set(base.dir=baseDir, base.url="/", out.format="markdown")
    opts_chunk$set(fig.path=figDir)
    
    # Convert .rmd --> .md (Jekyll-friendly)
    render_jekyll(highlight = "pygments")
    knit(input=inPath, output=outPath, envir = parent.frame())
}