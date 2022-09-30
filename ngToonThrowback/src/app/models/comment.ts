import { Toon } from "./toon";
import { User } from "./user";

export class Comment {
  id: number = 0;
  comment: string = "";
  active: boolean = false;
  createdDate: string = "";
  updatedDate: string = "";
  //user: User = new User();
  cartoon: Toon = new Toon();
  // parentComment: Comment = new Comment();
  // replies: Comment = new Comment();

  constructor(
    id: number = 0,
    comment: string = "",
    active: boolean = false,
    createdDate: string = "",
    updatedDate: string = "",
    // user: User = new User(),
    cartoon: Toon = new Toon(),
    // parentComment: Comment = new Comment(),
    // replies: Comment = new Comment(),
  ){
    this.id = id;
    this.comment = comment;
    this.active = active;
    this.createdDate = createdDate;
    this.updatedDate = updatedDate;
    //this.user = user;
   this. cartoon = cartoon;
    // this.parentComment = parentComment;
    // this.replies = replies;
  }
}
