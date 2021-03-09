cat .Rprofile

# setup R lib path ---------
#.libPaths("/home/sseth/R/x86_64-pc-linux-gnu-library/4.0")
vs = version
rver = paste0(vs$major, ".", strsplit(vs$minor, split = "\\.")[[1]][1])

# utils::osVersion
sess = utils::sessionInfo()
os = switch(sess$running,
            "Ubuntu 18.04.4 LTS" = "debian",
            "Ubuntu 20.04 LTS" = "debian",
            "Ubuntu 20.04.1 LTS" = "debian",
            "Red Hat Enterprise Linux" = "rhel"
);
.libPaths(file.path("~/R", os, rver))


# setup CRAN ---------
# if login node of seadragon; choose cran mirro:

options(bitmapType = "cairo")

hostname = Sys.info()["nodename"]
if(grepl("dragon", hostname)){
  options(repos = c(CRAN = "https://cran.rstudio.com"))
                    #SYNAPSE = "http://ran.synapse.org"))
}
# add sage bio networks:
# repos = c(CRAN = "https://cloud.r-project.org"
# "http://cran.fhcrc.org")


#setwd("~/projects2")
#.libPaths("~/Rlibs")
##, BioCsoft="https://www.bioconductor.org/packages/2)
#options(stringsAsFactors = FALSE)
#knitr::opts_chunk$set(dev = c("CairoPDF", "CairoPNG"))
#options(download.file.method = "wget")
#suppressMessages(source("http://bioconductor.org/biocLite.R"))

# load some awesome pacakges you ALWAYS need
# may be add flowr and wranglr as well
#try(library(RPushbullet))
#if(isTRUE('RDocumentation' %in% rownames(utils::installed.packages()))) options(defaultPackages = c(getOption('defaultPackages'), 'RDocumentation'))



# http://ftp.ussg.iu.edu/CRAN/
# https://ftp.ussg.iu.edu/CRAN/src/contrib
