#!/usr/bin/env bash

deployment_name=shield_test_omi

set -x

bosh -d "${deployment_name}" \
    deploy cassandra.yml \
        -v deployment_name="${deployment_name}" \
        -v network_name=cassandra-net \
    -o operations/admin-tools.yml \
    -o operations/use-bpm.yml \
    -o operations/scale-vms-and-disks.yml \
        -v cassandra_vm_type=medium \
        -v cassandra_persistent_disk_type=large \
    -o operations/scale-memory.yml \
        -v max_heap_size=2G \
        -v heap_newsize=400M \
    -o operations/shield-v7-agent.yml \
    -o operations/shield-v7-purge-archives.yml \
    -o operations/latest-versions.yml
