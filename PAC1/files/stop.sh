#!/bin/bash
qstat -f | grep $USER | cut -d' ' -f1 | xargs qdel
