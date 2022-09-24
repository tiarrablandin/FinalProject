import { Toon } from "./toon";

export class Rating {
  id: number = 0;
  rating: string = "";
  description: string = "";
  createdDate: string = "";
  updatedDate: string = "";
  // cartoon: Toon = new Toon();

  constructor(
    id: number = 0,
    rating: string = "",
    description: string = "",
    createdDate: string = "",
    updatedDate: string = "",
    // cartoon: Toon = new Toon(),
  ){
    this.id = id;
    this.rating = rating;
    this.description = description;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    // this.cartoon = cartoon;
  }
}
