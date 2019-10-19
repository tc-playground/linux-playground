package ns

import (
	"os"
	"path/filepath"
	"syscall"
)

// Mount namespace ************************************************************
//
// The 'pivot-root' syscall is used to move the parents processes root file
// system in a different place in the new mount  namespace and to mount a new
// namespace for the file system.
//
// * ```syscall: func PivotRoot(newroot string, putold string) (err error)```
//
// * 'newroot' and 'putold' must both be directories.
//
// * 'newroot' and 'putold' must not be on the same filesystem as the current root.
//
// * 'putold' must be underneath 'newroot'.
//
// * No other filesystem may be mounted on 'putold'.
//
func PivotRoot(newroot string) error {
	putold := filepath.Join(newroot, "/.pivot_root")

	// bind mount newroot to itself - this is a slight hack needed to satisfy the
	// pivot_root requirement that newroot and putold must not be on the same
	// filesystem as the current root
	if err := syscall.Mount(newroot, newroot, "", syscall.MS_BIND|syscall.MS_REC, ""); err != nil {
		return err
	}

	// create putold directory
	if err := os.MkdirAll(putold, 0700); err != nil {
		return err
	}

	// call pivot_root
	if err := syscall.PivotRoot(newroot, putold); err != nil {
		return err
	}

	// ensure current working directory is set to new root
	if err := os.Chdir("/"); err != nil {
		return err
	}

	// umount putold, which now lives at /.pivot_root
	putold = "/.pivot_root"
	if err := syscall.Unmount(putold, syscall.MNT_DETACH); err != nil {
		return err
	}

	// remove putold
	if err := os.RemoveAll(putold); err != nil {
		return err
	}

	return nil
}

// Mount a 'proc' file system onto /proc.
//
func MountProc(newroot string) error {
	source := "proc"
	target := filepath.Join(newroot, "/proc")
	fstype := "proc"
	flags := 0
	data := ""

	os.MkdirAll(target, 0755)
	if err := syscall.Mount(source, target, fstype, uintptr(flags), data); err != nil {
		return err
	}

	return nil
}
