import axios from 'axios';
import Axios, {
    AxiosResponse,
    AxiosError,
} from 'axios';

export class MeshupApi {

    private serviceURL: string = 'http://localhost:8233';

    public weather(city: string) {
        const baseURL = `${this.serviceURL}/weather/${city}`;
        return axios.get(baseURL);
    }

    public wiki(city: string) {
        const baseURL = `${this.serviceURL}/wiki/${city}`;
        return axios.get(baseURL);
    }

    public aqi(city: string) {
        const baseURL = `${this.serviceURL}/aqi/${city}`;
        return axios.get(baseURL);
    }

    public news(city: string) {
        const baseURL = `${this.serviceURL}/news/${city}`;
        return axios.get(baseURL);
    }

    public meshup(city: string) {
        const baseURL = `${this.serviceURL}/meshup/${city}`;
        return axios.get(baseURL);
    }

}
