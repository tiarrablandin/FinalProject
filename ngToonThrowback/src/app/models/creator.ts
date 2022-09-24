import { Toon } from "./toon";

export class Creator {
  id: number = 0;
  image: string = "";
  name: string = "";
  bio: string = "";
  url: string = "";
  // cartoon: Toon = new Toon();
  createdDate: string = "";
  updatedDate: string = "";

  constructor(
    id: number = 0,
    image: string = "",
    name: string = "",
    bio: string = "",
    url: string = "",
    createdDate: string = "",
    updatedDate: string = "",
    // cartoon: Toon = new Toon(),
    ){

    this.id = id;
    this.image = image;
    this.name = name;
    this.bio = bio;
    this.url = url;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    // this.cartoon = cartoon;
  }

}
