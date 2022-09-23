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
  active: string = "";
  createdDate: string = "";
  updatedDate: string = "";


  constructor(id: number = 0,
    image: string = "",
    email: string = "",
    username: string = "",
    password: string = "",
    firstName: string = "",
    lastName: string = "",
    bio: string = "",
    role: string = "",
    active: string = "",
    createdDate: string = "",
    updatedDate: string = "")
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
  }
}
