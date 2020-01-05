#!/bin/sh
nvidia-smi --query-gpu=power.draw --format=csv --loop-ms=10
