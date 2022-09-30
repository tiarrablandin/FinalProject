import { Fact } from "./fact";
import { Media } from "./media";
import { Toon } from "./toon";
import { Trivia } from "./trivia";
import { Comment } from './comment';

export class User {
  id: number = 0;
  image: string = "";
  email: string = "";
  username: string = "";
  password: string = "";
  firstName: string = "";
  lastName: string = "";
  bio: string = "";
  role: string = "";
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  cartoon: Toon = new Toon();
  favCartoons: Toon = new Toon();
  // media: Media = new Media();
  // comment: Comment []  = [];
  // facts: Fact = new Fact();
  //merch: Merch = new Merch();
  // trivia: Trivia = new Trivia();

  constructor(id: number = 0,
    image: string = "",
    email: string = "",
    username: string = "",
    password: string = "",
    firstName: string = "",
    lastName: string = "",
    bio: string = "",
    role: string = "",
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    cartoon: Toon = new Toon(),
    favCartoons: Toon = new Toon())
    // media: Media = new Media(),
    // comment: Comment [] = [])
    // facts: Fact = new Fact(),
    // merch: Merch = new Merch(),
    // trivia: Trivia = new Trivia())
  {
    this.id = id;
    this.email = email;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.bio = bio;
    this.role = role;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    this.cartoon = cartoon;
    this.favCartoons = favCartoons;
    // this.media = media;
    // this.comment = comment;
    // this.facts = facts;
    // this.merch = merch;
    // this.trivia = trivia;
  }
}
