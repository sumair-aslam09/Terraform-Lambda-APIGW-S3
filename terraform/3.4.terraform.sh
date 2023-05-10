#!/bin/bash

set -e

cd ../s3
npm ci

cd ../terraform
terraform apply


