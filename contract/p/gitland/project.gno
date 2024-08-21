package gitland

import (
	"time"
	"std"
)

type Project struct {
	id uint64
	name string
	owner std.Address
	description string
	backgroundImageCID string
	profileImageCID *string
	websiteLink string
	creationDate time.Time
	roundEndDate time.Time
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

func (p *Project) GetStats() *Stats {
	return p.stats
}

func (p *Project) GetOwner() std.Address {
	return p.owner
}

func InitProject(
	ID uint64,
	name string,
	owner std.Address,
	description string,
	backgroundImageCID string,
	profileImageCID *string,
	websiteLink string,
	creationDate time.Time,
	roundEndDate time.Time,
) *Project {
	return &Project{
		id: ID,
		name: name,
		owner: owner,
		description: description,
		backgroundImageCID: backgroundImageCID,
		profileImageCID: profileImageCID,
		websiteLink: websiteLink,
		creationDate: creationDate,
		roundEndDate: roundEndDate,
		stats: &Stats{
			fundingReceived: 0,
    		contributions: 0,
    		uniqueContributions: 0,
    		roundsParticipated: 0,
		},
	}
}
