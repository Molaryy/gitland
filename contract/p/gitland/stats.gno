package gitland

type Stats struct {
	fundingReceived uint64
    contributions uint64
    uniqueContributions uint64
    roundsParticipated uint64
}

/*
 - % comission, 0,2
*/

func (s *Stats) GetFundingReceived() uint64 {
    return s.fundingReceived
}

func (s *Stats) GetContributions() uint64 {
    return s.contributions
}

func (s *Stats) GetUniqueContributions() uint64 {
    return s.uniqueContributions
}

func (s *Stats) GetRoundsParticipated() uint64 {
    return s.roundsParticipated
}
