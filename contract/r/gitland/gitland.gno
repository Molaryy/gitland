package gitland

import (
	"time"
	"gno.land/p/demo/ufmt"
	"gno.land/p/demo/avl"
	"gno.land/p/molaryy/gitland"
	//"gno.land/p/demo/json"
)

var (
	currentTime time.Time

	// projects
	projectID uint64
	projects *avl.Tree

	// stats
	uDonations uint64
	nbProjectsRaised uint64
	totalFunds uint64
)

func init() {
	projects = avl.NewTree()
}

/* PROJECT */


func CreateProject(
	name string,
	description string,
	backgroundImageCID string,
	profileImageCID string,
	websiteLink string,
) {
	prflImg := ""

	if *profileImageCID == "" {
		prflImg = *profileImageCID
	} else {
		prflImg = nil
	}
	project := gitland.InitProject(
		ufmt.Sprintf("%d", projectID),
		name,
		description,
		backgroundImageCID,
		prflImg,
		websiteLink,
		currentTime.Now(),
	)
	projectID++
}

/* Each time GetProjects and GetProjectByID are called, call a function update days left */

func GetProjects() string {
	start := time.Now()
	year, month, day := start.Date()
	return  ufmt.Sprintf("%d", year) + "/" +  month.String() +  "/" + ufmt.Sprintf("%d", day)
}

func GetProjectByID(ID uint64) {
	
}


/* STATS */

func GetGitLandStats() (uint64, uint64, uint64) {
	return uDonations, nbProjectsRaised, totalFunds
}

func Render(path string) string {
	nbDonations := "<h1>Unique donations: " + ufmt.Sprintf("%d", uDonations) + "</h1>"
	nbProjectsRaised := "<h1>Projects raised funds: " + ufmt.Sprintf("%d", nbProjectsRaised) + "</h1>"
	tFunds :=  "<h1>Total funds: " + ufmt.Sprintf("%d", totalFunds) + "$</h1>"
	projects := "<h1>Projects</h1>" + GetProjects()

	return  nbDonations + nbProjectsRaised + tFunds + "</br>" + projects
}
