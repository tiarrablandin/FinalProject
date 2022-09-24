import { ToonService } from './../../services/toon.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css'],
})
export class NavbarComponent implements OnInit {
  loginUser: User = new User();
  closeResult: string = '';
  searchTerm: string = "";

  constructor(
    private modalService: NgbModal,
    private auth: AuthService,
    private router: Router
  ) {}

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

  ngOnInit(): void {}

  login(user: User) {
    console.log('Logging in');
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedInUser) => {
        console.log(loggedInUser);
        this.router.navigateByUrl('home');
      },
      error: (err) => {
        console.error('Error logging in');
        console.error(err);
      },
    });
  }

  loggedIn() {
    return this.auth.checkLogin();
  }

  logout() {
    console.log('Logging out.');
    this.auth.logout();
    this.router.navigateByUrl('home');
  }

  search(){
    // this.toonService.search(this.searchTerm).subscribe({
    //   next: (data) => {
    //     this.ToonService = data;
    //   },
    //   error: (err) => {
    //     console.error("RockComponent.search(): error searching for rock");
    //     console.error(err);
    //   }
    // });
  }

}
