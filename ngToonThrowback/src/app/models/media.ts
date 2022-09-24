import { Toon } from "./toon";
import { User } from "./user";

export class Media {
  id: number = 0;
  image: string = "";
  title: string = "";
  description: string = "";
  url: string = "";
  season: number = 0;
  episodeNum: number = 0;
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  cartoon: Toon = new Toon();
  // user: User = new User();

  constructor(
    id: number = 0,
    image: string = "",
    title: string = "",
    description: string = "",
    url: string = "",
    season: number = 0,
    episodeNum: number = 0,
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    cartoon: Toon = new Toon(),
    // user: User = new User()
  ){
    this.id = id;
    this.image = image;
    this.title = title;
    this.description = description;
    this.url = url;
    this.season = season;
    this.episodeNum = episodeNum;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    this.cartoon = cartoon;
    // this.user = user;
  }
}
