package gitland

import (
	"time"
)

type Project struct {
	ID uint64
	name string
	description string
	backgroundImageCID string
	profileImageCID *string
	websiteLink string
	creationDate time.Time
	roundEndDate time.Time
	daysLeft uint64
	stats Stats
}


func (p *Project) GetID() uint64 {
	return p.ID
}

func (p *Project) Getname() string {
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

func (p *Project) GetDaysLeft() uint64 {
	return p.daysLeft
}

func (p *Project) Getstats() Stats {
	return p.stats
}

func (p *Project) GetDaysLeft() uint64 {
	// TODO
}

func (p *Project) UpdateDaysLeft() bool {
	// TODO
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
) *Project {
	var stats Stats

	return &Project{
		ID: ID,
		name: name,
		description: description,
		backgroundImageCID: backgroundImage,
		profileImageCID: profileImage,
		websiteLink: websiteLink,
		creationDate: creationDate,
		roundEndDate: roundEndDate,
		daysLeft: 0 // set days left,
		stats: stats,
	}
}
