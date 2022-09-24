import { Toon } from "./toon";
import { User } from "./user";

export class Fact {
  id: number =0;
  fact: string = "";
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  cartoon: Toon = new Toon();
  // user: User = new User();

  constructor(
    id: number =0,
    fact: string = "",
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    cartoon: Toon = new Toon(),
    // user: User = new User()
  ){
    this.id = id;
    this.fact = fact;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    this.cartoon = cartoon;
    // this.user = user;
  }
}
