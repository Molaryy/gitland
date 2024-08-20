import './App.css'
import Navbar from "./components/Navbar/Navbar.tsx";
import Footer from "./components/Footer/Footer.tsx";
import Projects from "./components/Projects/Projects.tsx";
import Numbers from "./components/Numbers/Numbers.tsx";
import {BrowserRouter, Route, Routes} from "react-router-dom";
import {ChakraProvider} from "@chakra-ui/react";

function App() {

    return (
        <div className={"app"}>
            <ChakraProvider>
                <Navbar/>
                <BrowserRouter>
                    <Routes>
                        <Route path={"/"} element={
                            <div>
                                <Numbers/>
                                <Projects/>
                            </div>
                        }/>
                        <Route path={"/home"} element={<h1>Hello</h1>}/>
                    </Routes>
                </BrowserRouter>
                <Footer/>
            </ChakraProvider>
        </div>
    )
}

export default App;
