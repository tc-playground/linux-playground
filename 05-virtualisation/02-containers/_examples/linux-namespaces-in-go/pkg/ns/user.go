package ns

import (
	"os"
	"syscall"
)

// User namespace *************************************************************
//
// * The User namespace provides isolation of UIDs and GIDs.
//
// * There can be multiple, distinct User namespaces in use on the same host
//   at any given time.
//
// * Every Linux process runs in one of these User namespaces.
//
// * User namespaces allow for the UID of a process in User namespace 1 to be
//   different to the UID for the same process in User namespace 2.
//
// * UID/GID mapping provides a mechanism for mapping IDs between two separate
//   User namespaces. The parent process sees the original ID, the child the
//   mapped ID.
//
// See user_namespaces(7).
//
func CreateSysProcIDMappings(containerUID, containerGID int) ([]syscall.SysProcIDMap, []syscall.SysProcIDMap) {
	// Create 'id' usernamespace mapping.
	uidMappings := []syscall.SysProcIDMap{
		{
			ContainerID: containerUID, // The uid inside the new User namespace.
			HostID:      os.Getuid(),  // Ho
			Size:        1,            // Can be used to map a range of ids
		},
	}
	// Create 'gid' usernamespace mapping.
	gidMapMappings := []syscall.SysProcIDMap{
		{
			ContainerID: containerGID, // The gid inside the new User namespace.
			HostID:      os.Getgid(),
			Size:        1, // Can be used to map a range of ids
		},
	}

	return uidMappings, gidMapMappings
}
