import { MediaService } from './../../services/media.service';
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
import { Merch } from 'src/app/models/merch';
import { Media } from 'src/app/models/media';

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
  userMerchs: Merch[] = [];
  closeResult: string = '';
  editUser: User | null = null;
  editMedia: Media | null = null;
  selectedMedia: Media | null = null;
  editToon: Toon | null = null;
  selectedToon: Toon | null = null;

  constructor(
    private authService: AuthService,
    private userService: UserService,
    private toonService: ToonService,
    private merchService: MerchService,
    private modalService: NgbModal,
    private mediaService: MediaService
    ) { }

  ngOnInit(): void {
    this.authService.getLoggedInUser().subscribe(
       (liUser) => {
        this.loggedIn = liUser;
        this.reload();

      }
    )
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
      this.userMerchs = data
    },
    error: (err) => {
      console.error('MerchListComponent.reload(): error loading merch:');
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
    this.loadUserMerch();
    this.loadUserToons();
  }


openCartoon(content: any) {
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

openMedia(content: any) {
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

updateUser() {
  if (this.editUser) {
  this.userService.update(this.editUser).subscribe(
    {
      next: (data) => {
        this.selected = data;
        this.editUser = null;
        this.reload();
      },
      error: (err) => {
        console.error('UserListComponent.updateUser(): error updating user:');
        console.error(err);
      }
    }
  );
  }
}
delete(id: number) {
  this.userService.destroy(id).subscribe(
    {
      next: () => {
        this.authService.logout();
        this.reload();
      },
      error: (err) => {
        console.error('UserListComponent.deleteUser(): error deleting user:');
        console.error(err);
      }
    }
  );
  }
  updateMedia(updatedMedia: Media) {
    this.mediaService.update(updatedMedia).subscribe(
      {
        next: (data) => {
          this.selectedMedia = data;
          this.editMedia = null;
          this.reload();
        },
        error: (err) => {
          console.error('MediaListComponent.updateMedia(): error updating media:');
          console.error(err);
        }
      }
    );
    }

    deleteMedia(id: number) {
    this.mediaService.destroy(id).subscribe(
      {
        next: () => {
          this.reload();
        },
        error: (err) => {
          console.error('MediaListComponent.deleteMedia(): error deleting media:');
          console.error(err);
        }
      }
    );

    }
    deleteToon(id: number) {
      this.toonService.destroy(id).subscribe({
        next: () => {
          this.reload();
        },
        error: (err) => {
          console.error('ToonListComponent.deleteToon(): error deleting Toon:');
          console.error(err);
        },
      });
    }

    updateToon() {
      if(this.editToon){
        this.toonService.update(this.editToon).subscribe({
          next: (data) => {
            this.selectedToon = data;
            this.editToon = null;
            this.reload();
          },
          error: (err) => {
            console.error('ToonListComponent.updateToon(): error updating Toon:');
            console.error(err);
          },
        });
      }
    }
    }

