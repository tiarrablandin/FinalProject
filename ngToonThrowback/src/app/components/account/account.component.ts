import { MerchService } from './../../services/merch.service';
import { ToonService } from 'src/app/services/toon.service';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { userInfo } from 'os';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Toon } from 'src/app/models/toon';
import { throws } from 'assert';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';

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
  closeResult: string = '';

  constructor(
    private authService: AuthService,
    private userService: UserService,
    private toonService: ToonService,
    private merchService: MerchService,
    private modalService: NgbModal
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
  loadUserMerch() {
this.merchService.listUserMerch(this.loggedIn.id).subscribe(
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


open(content: any) {
  this.modalService
    .open(content, { ariaLabelledBy: 'modal-basic-title' })
    .result.then(
      (result: any) => {
        this.closeResult = `Closed with: ${result}`;
      },
      (reason: any) => {
        this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
      }
    );
}
private getDismissReason(reason: any): string {
  if (reason === ModalDismissReasons.ESC) {
    return 'by pressing ESC';
  } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
    return 'by clicking on a backdrop';
  } else {
    return `with: ${reason}`;
  }
}
}
