import projects from "../../test.data.ts";
import './Projects.css'
import giftBox from "/gift-box.png"

const Projects = () => {

    const limitSizeDescription = (description: string): string => {
        if (description.length <= 300) {
            return description; // No need to truncate if the description is already short enough
        }

        const lastSpaceIndex = description.lastIndexOf(' ', 300);

        if (lastSpaceIndex > -1) {
            return description.substring(0, lastSpaceIndex) + "...";
        }

        return description.substring(0, 300) + "...";
    };

    const goToProjectID = (projectID: number) => {
        console.log("Clicked on id: ", projectID)
    }

    return (
        <div className={"projects"}>
            {projects.map((item) => (
                <div key={item.id} className={"project-container"}>
                    <img  src={item.backgroundImg} alt={"project-background-image"}/>
                    <div className={"project-text-container"}>
                        <h3 id={"project-name"}>{item.name}</h3>
                        <p id={"project-description"}>{ limitSizeDescription(item.description)}</p>
                    </div>
                    <button id={"project-button-donate"} onClick={() => goToProjectID(item.id)}>Donate <img id={"gift-box-button"} src={giftBox} alt={"gift-box"}/> </button>
                </div>
            ))}
        </div>
    )
}

export default Projects;
