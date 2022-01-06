import { ethers } from "ethers";
import abi from "../utils/Keyboards.json";

const contractAddress = '0x274698Dd49f7e0988A0568862C7BCF27D3f33382';
const contractABI = abi.abi;

export default function getKeyboardsContract(ethereum) {
  if(ethereum) {
    const provider = new ethers.providers.Web3Provider(ethereum);
    const signer = provider.getSigner();
    return new ethers.Contract(contractAddress, contractABI, signer);
  } else {
    return undefined;
  }
}