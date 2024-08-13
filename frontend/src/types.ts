type Stats = {
    fundingReceived: number,
    contributions: number,
    uniqueContributions: number,
    roundsParticipated: number,
}

export type Project = {
    id: number,
    name: string,
    description: string,
    backgroundImg: string,
    profileImg: string | undefined,
    websiteLink: string,
    creationDate: Date,
    stats: Stats
}
