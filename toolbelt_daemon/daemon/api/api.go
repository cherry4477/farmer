package api

import (
	"github.com/gin-gonic/gin"
)

func Listen() {
	server := gin.Default()

	registerRoutes(server)

	server.Run(":80")
}

func registerRoutes(server *gin.Engine) {
	podRoute := server.Group("/pod")
	{
		podRoute.POST("/create", Create)
		podRoute.GET("/state/:pod", State)
	}
}
