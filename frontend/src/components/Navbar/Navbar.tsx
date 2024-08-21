import './Navbar.css'
import {Button} from "@chakra-ui/react";
import {useState} from "react";
import {useAccountStore} from "../../stores/account.ts";
import {AdenaService} from "../../service/adena/adena.ts";
import {constants} from "../../constants.ts";
import {IAccountInfo} from "../../service/adena/adena.types.ts";

const Navbar = () => {
    const [isLoading, setIsLoading] = useState<boolean>(false);
    const {address, setAddress, setUser} = useAccountStore();

    const handleWalletConnect = async () => {
        setIsLoading(true);

        try {
            // Attempt to establish a connection
            await AdenaService.establishConnection("gnovox");

            // Make sure the network is valid
            await AdenaService.switchNetwork(constants.chainID);

            // Get the account info
            const accountInfo: IAccountInfo = await AdenaService.getAccountInfo();

            // Update the account context
            setAddress(accountInfo.address);

        } catch (e) {
            console.error(e);
        }

        setIsLoading(false);
    };

    const onLogout = () => {
        setAddress(null);
        setUser(null);
    };

    return (
        <div className={"navbar"}>
            <h1>Gitland</h1>
            <Button
                isLoading={isLoading}
                onClick={address === null ? handleWalletConnect : onLogout}> {address === null ? 'Connect wallet' : 'Logout'}</Button>
        </div>
    )
}

export default Navbar;
