package gitland

import (
	//"time"

	"gno.land/p/demo/ufmt"
	//"gno.land/p/demo/json"
)

var (
	uDonations uint
	nbProjectsRaised uint
	totalFunds uint
)

type Project struct {
    id string
    name string
    link string
    description string
}

func getProjects() string {
	return "test"
}

func Render(path string) string {
	nbDonations := "<h1>Unique donations: " + ufmt.Sprintf("%d", uDonations) + "</h1>"
	nbProjectsRaised := "<h1>Projects raised funds: " + ufmt.Sprintf("%d", nbProjectsRaised) + "</h1>"
	tFunds :=  "<h1>Total funds: " + ufmt.Sprintf("%d", totalFunds) + "$</h1>"
	projects := "<h1>Projects</h1>" + getProjects()

	return  nbDonations + nbProjectsRaised + tFunds + "</br>" + projects
}
