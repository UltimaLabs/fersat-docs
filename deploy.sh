#!/bin/bash

./build.sh && cd provisioning && ./fersat-deploy-docs.yml && cd ..
