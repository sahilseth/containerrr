#!/bin/sh
#BSUB -W 72:00
#BSUB -n 24
#BSUB -M 300
#BSUB -q long
#BSUB -o $HOME/rstudio/logs/
#BSUB -e $HOME/rstudio/logs/
#BSUB -J rstudio


# example commands:
# access more cpus
# bsub -n 12 < ~/bin/R/rserver.sh

export PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${USER}@seadragon

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${USER}
   password: ${PASSWORD}

When done using RStudio Server, terminate the job by:
   bkill ${LSB_JOBID}

END

sif_path=$HOME/sifs

if [ ! -e ${HOME}/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file\n\n'
  echo 'R_LIBS_USER=~/R/%p-library/%v' >> ${HOME}/.Renviron
fi

module load singularity/3.5.2

# lately there were issues with this:
# sif=${sif_path}/rstudio_geospatial_4.0.0-ubuntu18.04.sif
# sif=${sif_path}/rstudio_geospatial_4.0.0.sif
sif=${sif_path}/rstudio_geospatial_4.0.3_v3.sif

# bind rstudio folders
bind_rstudio="--bind $HOME/sifs/rstudio/var:/var/run/rstudio-server --bind $HOME/sifs/rstudio/tmp:/tmp/rstudio-server --bind $HOME/misc/R/rserver_hpc.conf:/etc/rstudio/rserver.conf"


# By default the only host file systems mounted within the container are $HOME, /tmp, /proc, /sys, and /dev.
cmd="singularity exec ${bind_rstudio} ${sif} rserver --www-port ${PORT} --auth-none=0 --auth-pam-helper-path=pam-helper"
echo $cmd
$cmd
