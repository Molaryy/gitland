package gitland

import (
	"time"
)

type Project struct {
	id uint64
	name string
	description string
	backgroundImageCID string
	profileImageCID *string
	websiteLink string
	creationDate time.Time
	roundEndDate time.Time
	daysLeft int
	stats *Stats
}


func (p *Project) GetID() uint64 {
	return p.id
}

func (p *Project) GetName() string {
	return p.name
}

func (p *Project) GetDescription() string {
	return p.description
}

func (p *Project) GetBackgroundImageCID() string {
	return p.backgroundImageCID
}

func (p *Project) GetProfileImageCID() *string {
	return p.profileImageCID
}

func (p *Project) GetWebsiteLink() string {
	return p.websiteLink
}

func (p *Project) GetCreationDate() time.Time {
	return p.creationDate
}

func (p *Project) GetRoundEndDate() time.Time {
	return p.roundEndDate
}

func (p *Project) GetDaysLeft() int {
	return p.daysLeft
}

func (p *Project) GetStats() *Stats {
	return p.stats
}

func GetDaysLeft(roundEndDate time.Time) int {
	untilDuration := time.Until(roundEndDate)

	return int(untilDuration.Hours() / 24)
}

func (p *Project) UpdateDaysLeft() bool {
	p.daysLeft = GetDaysLeft(p.roundEndDate)

	if p.daysLeft <= 0 {
		return false
	} else {
		return true
	}
}

func InitProject(
	ID uint64,
	name string,
	description string,
	backgroundImageCID string,
	profileImageCID *string,
	websiteLink string,
	creationDate time.Time,
	roundEndDate time.Time,
) (*Project, error) {
	// TODO: add real error handling here

	return &Project{
		id: ID,
		name: name,
		description: description,
		backgroundImageCID: backgroundImageCID,
		profileImageCID: profileImageCID,
		websiteLink: websiteLink,
		creationDate: creationDate,
		roundEndDate: roundEndDate,
		daysLeft: GetDaysLeft(roundEndDate),
		stats: &Stats{
			fundingReceived: 0,
    		contributions: 0,
    		uniqueContributions: 0,
    		roundsParticipated: 0,
		},
	}, nil
}
