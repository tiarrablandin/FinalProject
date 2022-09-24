import { Toon } from "./toon";

export class Network {
  id: number = 0;
  image: string = "";
  name: string = "";
  description: string = "";
  url: string = "";
  createdDate: string = "";
  updatedDate: string = "";
  // cartoon: Toon = new Toon();

  constructor(
    id: number = 0,
    image: string = "",
    name: string = "",
    description: string = "",
    url: string = "",
    createdDate: string = "",
    updatedDate: string = "",
    // cartoon: Toon = new Toon()
  ){
    this.id = id;
    this.image = image;
    this.name = name;
    this.description = description;
    this.url = url;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    // this.cartoon = cartoon;
  }

}
