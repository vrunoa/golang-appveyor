package main

import (
  "fmt"
  "os"
  //"github.com/jessevdk/go-flags"
  //"os/signal"
)

func cleanup() {
  // TODO - call api to cancel Job
  fmt.Println("See you soon!")
}

func main() {
  fmt.Println("Something")
  os.Exit(1)
}
