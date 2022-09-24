import { Toon } from "./toon";
import { User } from "./user";

export class Trivia {
  id: number = 0;
  question: string = "";
  answer: string = "";
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  cartoon: Toon = new Toon();
  user: User = new User();

  constructor(
    id: number = 0,
    question: string = "",
    answer: string = "",
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    cartoon: Toon = new Toon(),
    user: User = new User()
  ){
    this.id = id;
    this.question = question;
    this.answer = answer;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    this.cartoon = cartoon;
    this.user = user;
  }
}
