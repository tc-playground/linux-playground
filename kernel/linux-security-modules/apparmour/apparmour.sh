#!/bin/bash

# AppArmor ====================================================================
#
# AppArmor is a kernel enhancement to confine programs to a limited set of 
# resources. AppArmor's unique security model is to bind access control 
# attributes to programs rather than to users.
#
# =============================================================================

function apparmor::status() {
    sudo apparmor_status
}