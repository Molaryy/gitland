package gitland

import (
	"std"
	"time"
	"errors"
	"gno.land/p/demo/ufmt"
	"gno.land/p/demo/avl"
	"gno.land/p/molaryy/gitland"
	"gno.land/p/demo/json"
)

const (
	gitlandAddress std.Address = "g199esk77thuk3lhzz2ktmkgffk7d9eh7hn0kmqt"
	comission int64 = 20
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

func getStringDate(t time.Time) string {
	month :=int(t.Month())
	return ufmt.Sprintf("%d", t.Day()) + "/" + ufmt.Sprintf("%d", month) + "/" + ufmt.Sprintf("%d", t.Year())
}


func checkEndDateWithCurrentDate(
	endYear int,
	endMonth int,
	endDay int,
	currentTime time.Time,
) {

	currentYear := currentTime.Year()
	currentMonth := int(currentTime.Month())
	currentDay := currentTime.Day()

	if endYear < currentTime.Year() {
		panic(errors.New("The round's end year must be equal or superior to the current year"))
	}

	if endMonth < 1 || endMonth > 12 {
		panic(errors.New("The month should be between 1 and 12"))
	} else if endYear == currentYear && endMonth < currentMonth {
		panic(errors.New("The month must be greater than or equal to the current month if the round's end year is the same as the creation year."))
	}

	if endDay < 1 || endDay > 31 {
		panic(errors.New("The round's end day must be between 1 and 31"))
	} else if endYear == currentYear && endMonth == currentMonth && endDay <= currentDay {
		panic(errors.New("The round's end day must be superior to the current day"))
	}
}

func CreateProject(
	name string,
	description string,
	backgroundImageCID string,
	profileImageCID string,
	websiteLink string,
	endYear int,
	endMonth int,
	endDay int,
) {
	caller := std.GetOrigCaller()
	var prflImg *string
	var endDate time.Time = time.Now()
	var currentTime time.Time = endDate


	if profileImageCID == "" {
		*prflImg = profileImageCID
	} else {
		prflImg = nil
	}

	checkEndDateWithCurrentDate(endYear, endMonth, endDay, currentTime)
	endDate.AddDate(endYear, endMonth, endDay)
	project := gitland.InitProject(
		projectID,
		name,
		caller,
		description,
		backgroundImageCID,
		prflImg,
		websiteLink,
		time.Now(),
		endDate,
	)

	projects.Set(ufmt.Sprintf("%d", projectID), project)
	projectID++
	nbProjectsRaised++
}

func DonateProjectByID(ID string) {
	coinSent := std.GetOrigSend()
	banker := std.GetBanker(std.BankerTypeOrigSend)
	realmAddr := std.CurrentRealm().Addr()
	it, ok := projects.Get(ID)

	if coinSent.AmountOf("ugnot") < comission + 1 {
		panic(errors.New("You should at least send " + ufmt.Sprintf("%d", comission + 1) + "ugnot"))
	}

	if ok == false {
		panic(errors.New("Project id not found"))
	}

	project := it.(*gitland.Project)

	if project == nil {
		panic("The project found is null")
	}

	var coin std.Coin = std.NewCoin("ugnot", comission)

	banker.SendCoins(realmAddr, gitlandAddress, std.Coins{coin})
	coinsToSendAfterComission := coinSent[0].Sub(coin)
	banker.SendCoins(realmAddr, project.GetOwner(), std.Coins{coinsToSendAfterComission})
	uDonations++
	totalFunds += uint64(std.Coins{coinsToSendAfterComission}.AmountOf("ugnot"))
}


func getProjectHTML(project *gitland.Project) string {
	projectsStr := ""
	projectsStr += "<div style='width: 250px; height: 500px;margin: 0;padding: 0;' ><h2>Project ID:" + ufmt.Sprintf("%d", project.GetID()) + "</h2>" 
	projectsStr += "<p><b>Name</b>: " + project.GetName() + "</p>"
	projectsStr += "<p><b>Description</b>: " + project.GetDescription() + "</p>"
	projectsStr += "<p><b>Project link</b>: " + project.GetWebsiteLink() + "</p>"
	projectsStr += "<p><b>Creation date</b>: " + getStringDate(project.GetCreationDate()) + "</p>"
	projectsStr += "<p><b>Round end date</b>: " + getStringDate(project.GetRoundEndDate()) + "</p>"
	return projectsStr
}

func getProjectsToRender() string {
	projectsStr := ""

	projects.Iterate("", "", func (id string, it interface{}) bool {
		project := it.(*gitland.Project)
		projectsStr += getProjectHTML(project)
		return false
	})

	return projectsStr
}

func checkNil(str *string) string {
	if str == nil {
		return ""
	}
	return *str
}

func getProjectJSON(project *gitland.Project) *json.Node {
	var stats *gitland.Stats = project.GetStats()

	projectFields := json.ObjectNode("", map[string]*json.Node{
		"id": json.NumberNode("id", float64(project.GetID())),
		"name": json.StringNode("name", project.GetName()),
		"description": json.StringNode("description", project.GetDescription()),
		"backgroundImageCID": json.StringNode("backgroundImageCID", project.GetBackgroundImageCID()),
		"profileImageCID": json.StringNode("profileImageCID", checkNil(project.GetProfileImageCID())),
		"websiteLink": json.StringNode("websiteLink", project.GetWebsiteLink()),
		"creationDate": json.StringNode("creationDate", getStringDate(project.GetCreationDate())),
		"roundEndDate": json.StringNode("roundEndDate", getStringDate(project.GetRoundEndDate())),
		"stats": json.ObjectNode("stats", map[string]*json.Node{
			"fundingReceived": json.NumberNode("fundingReceived", float64(stats.GetFundingReceived())),
			"contributions": json.NumberNode("contributions", float64(stats.GetContributions())),
			"uniqueContributions": json.NumberNode("uniqueContributions", float64(stats.GetUniqueContributions())),
			"roundsParticipated": json.NumberNode("roundsParticipated", float64(stats.GetRoundsParticipated())),
		}),
	})
	return projectFields
}

func GetProjectsJSON() string {
	projectsJson := json.ArrayNode("", []*json.Node{})
	projectObject := json.ObjectNode("", map[string]*json.Node{})

	projects.Iterate("", "", func(id string, it interface{}) bool {
		project := it.(*gitland.Project)
		projectFields := getProjectJSON(project)
		projectObject.AppendObject(ufmt.Sprintf("%d", project.GetID()), projectFields)
		return false
	})
	projectsJson.AppendArray(projectObject)
	encoded, err := json.Marshal(projectsJson)
	if err != nil {
		panic(err)
	}
	return string(encoded)
}

func GetProjectByIDJSON(ID string) string {
	it, ok := projects.Get(ID)

	if ok == false {
		panic(errors.New("Project id not found"))
	}

	project := it.(*gitland.Project)

	if project == nil {
		return ""
	}

	projectFields := getProjectJSON(project)
	encoded, err := json.Marshal(projectFields)

	if err != nil {
		panic(err)
	}
	return string(encoded)
}

func GetGitLandStats() (uint64, uint64, uint64) {
	return uDonations, nbProjectsRaised, totalFunds
}

func Render(path string) string {
	nbDonations := "<h1>Unique donations: " + ufmt.Sprintf("%d", uDonations) + "</h1>"
	nbProjectsRaised := "<h1>Projects raised funds: " + ufmt.Sprintf("%d", nbProjectsRaised) + "</h1>"
	tFunds :=  "<h1>Total funds: " + ufmt.Sprintf("%d", totalFunds) + " UGNOT</h1>"
	projectsToRender := "<h1>Projects</h1>" + getProjectsToRender()

	_, ok := projects.Get(path)

	if ok == false {
		return nbDonations + nbProjectsRaised + tFunds + "</br>" + projectsToRender
	}

	return "test"
}
