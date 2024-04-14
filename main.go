// Description: A simple Gin server that returns a JSON response with a message "pong" when a GET request is made to the /ping endpoint.
package main
 
import (
  "net/http"
 
  "github.com/gin-gonic/gin"
)
 
func main() {
// Create a new Gin server
  r := gin.Default()
  // Define a GET request handler for the /ping endpoint
  r.GET("/ping", func(c *gin.Context) {
	// Return a JSON response with a message "pong"
    c.JSON(http.StatusOK, gin.H{
      "message": "pong",
    })
  })
  // Start the server on port 8080
  r.Run()
}