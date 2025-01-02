#!/bin/bash
docker compose run -it --rm rockylinux ./sumarize_sv.sh
docker compose run -it --rm rockylinux ./sumarize_mm.sh
docker compose run -it --rm rockylinux ./sumarize_counters.sh
docker compose run -it --rm rockylinux ./sumarize_npb.sh
docker compose run -it --rm rockylinux ./sumarize_scheduling.sh

