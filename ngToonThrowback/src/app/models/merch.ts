import { Toon } from './toon';
import { User } from './user';
export class Merch {
  id: number = 0;
  cartoon: Toon = new Toon();
  url: string = "";
  image: string = "";
  user: User = new User();
  createdDate: string = "";
  updatedDate: string = "";
  active: string = "";

  constructor(
    id: number = 0,
  cartoon: Toon = new Toon(),
  url: string = "",
  image: string = "",
  user: User = new User(),
  createdDate: string = "",
  updatedDate: string = "",
  active: string = ""
  ) {
    this.id = id;
  this.cartoon = cartoon
  this.url = url;
  this.image = image;
  this.user = user;
  this.createdDate = createdDate;
  this.updatedDate = updatedDate;
  this.active = active;
  }
}
