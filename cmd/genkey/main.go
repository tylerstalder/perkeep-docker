// package main generates a new PGP secret key
package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"golang.org/x/crypto/openpgp"
)

func main() {
	secring := flag.String("secring", "identity-secring.gpg",
		"secret keyring file path; will be overwritten.")
	flag.Parse()
	// Generate a new key pair
	ent, err := openpgp.NewEntity("", "perkeep", "", nil)
	if err != nil {
		log.Fatal(err)
	}
	// Write private key to disk
	f, err := os.OpenFile(*secring, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0600)
	if err != nil {
		log.Fatal(err)
	}
	if err = ent.SerializePrivate(f, nil); err != nil {
		log.Fatal(err)
	}
	err = f.Close()
	if err != nil {
		log.Fatal(err)
	}
	// Print short key ID to stdout
	fmt.Println(ent.PrimaryKey.KeyIdShortString())
}
