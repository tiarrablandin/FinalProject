import { Creator } from './creator';
import { Network } from './network';
import { Rating } from './rating';
import { User } from './user';
export class Toon {
  id: number = 0;
  image: string = "";
  name: string = "";
  description: string = "";
  url: string = "";
  airingDate: string = "";
  finaleDate: string = "";
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  creator: Creator = new Creator();
  network: Network = new Network();
  rating: Rating = new Rating();
  // user: User = new User();

  constructor(id: number = 0,
    image: string = "",
    name: string = "",
    description: string = "",
    url: string = "",
    airingDate: string = "",
    finaleDate: string = "",
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    creator: Creator = new Creator(),
    network: Network = new Network(),
    rating: Rating = new Rating(),
    // user: User = new User()
  ){
    this.id = id;
    this.image = image;
    this.name = name;
    this.description = description;
    this.url = url;
    this.airingDate = airingDate;
    this.finaleDate = finaleDate;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    this.creator = creator;
    this.network = network;
    this.rating = rating;
    // this.user = user;
  }
}
