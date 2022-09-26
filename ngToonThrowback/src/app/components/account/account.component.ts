import { ToonService } from 'src/app/services/toon.service';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { userInfo } from 'os';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Toon } from 'src/app/models/toon';
import { throws } from 'assert';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css']
})
export class AccountComponent implements OnInit {
  users: User[] = [];
  loggedIn: User = new User();
  selected: User | null = null;
  userToons: Toon[] = [];

  constructor(
    private authService: AuthService,
    private userService: UserService,
    private toonService: ToonService
    ) { }

  ngOnInit(): void {
    this.authService.getLoggedInUser().subscribe(
       (liUser) => {
        this.loggedIn = liUser;
        this.loadUserToons();
      }
    )
    this.reload();
  }

  loadUserToons() {
this.toonService.listUserCartoons(this.loggedIn.id).subscribe(
  {
    next: (data: any) => {
      this.userToons = data
    },
    error: (err) => {
      console.error('MediaListComponent.reload(): error loading media:');
      console.error(err);
    }
  }
)

  }


  reload() {
    this.userService.show(this.loggedIn.id).subscribe(
    {
      next: (data: any) => {
        this.users = data
      },
      error: (err) => {
        console.error('MediaListComponent.reload(): error loading media:');
        console.error(err);
      }
    }
    );
  }

}
