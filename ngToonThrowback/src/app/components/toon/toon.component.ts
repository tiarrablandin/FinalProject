import { MerchService } from './../../services/merch.service';
import { AuthService } from 'src/app/services/auth.service';
import { Toon } from './../../models/toon';
import { Component, OnInit, HostListener, ViewChild, ElementRef } from '@angular/core';
import { ToonService } from 'src/app/services/toon.service';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { Media } from 'src/app/models/media';
import { Merch } from 'src/app/models/merch';
import { MediaService } from 'src/app/services/media.service';
import { ConditionalExpr } from '@angular/compiler';
import { Network } from 'src/app/models/network';
import { Rating } from 'src/app/models/rating';

@Component({
  selector: 'app-toon',
  templateUrl: './toon.component.html',
  styleUrls: ['./toon.component.css'],
})

export class ToonComponent implements OnInit {

  selected: Toon | null = null;
  newToon: Toon = new Toon();
  editToon: Toon | null = null;
  loggedInUser: User | null = null;
  closeResult: string = '';
  newMedia: Media = new Media();
  newMerch: Merch = new Merch();
  toonMedia: Media[] = [];
  toonMerch: Merch[] = [];
  toons: Toon[] = [];
  networks: Network[] = [];
  ratings: Rating[] = [];

  arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  totalCards: number = this.arr.length;
  currentPage: number = 1;
  pagePosition: string = "0%";
  cardsPerPage: number = 0;
  totalPages: number = 0;
  overflowWidth: string = "";
  cardWidth: string = "";
  containerWidth: number = 0;
  @ViewChild("container", { static: true, read: ElementRef })
  container: ElementRef = new ElementRef("");
  @HostListener("window:resize") windowResize() {
    let newCardsPerPage = this.getCardsPerPage();
    if (newCardsPerPage != this.cardsPerPage) {
      this.cardsPerPage = newCardsPerPage;
      this.initializeSlider();
      if (this.currentPage > this.totalPages) {
        this.currentPage = this.totalPages;
        this.populatePagePosition();
      }
    }
  }

  constructor(
    private toonService: ToonService,
    private currentRoute: ActivatedRoute,
    private authService: AuthService,
    private modalService: NgbModal,
    private merchService: MerchService,
    private mediaService: MediaService,
    private router: Router
  ) {
    this.router.events.subscribe(() => {
      this.selected = null;
   });
  }

  ngOnInit(): void {
    this.cardsPerPage = this.getCardsPerPage();
    this.initializeSlider();
     if(this.authService.checkLogin()){
       this.getLoggedInUser();
     }
    let searchTerm = this.currentRoute.snapshot.paramMap.get('searchTerm');
    if (searchTerm) {
      this.search(searchTerm);
    } else {
      this.reload();
    }
  }

  search(searchTerm: string) {
    this.toonService.search(searchTerm).subscribe({
      next: (data) => {
        this.selected = null;
        this.toons = data;
      },
      error: (err) => {
        console.error('ToonComponent.search(): error searching for cartoon');
        console.error(err);
      },
    });
  }

  reload() {
    this.toonService.index().subscribe({
      next: (data) => {
        this.toons = data;
      },
      error: (err) => {
        console.error('ToonListComponent.reload(): error loading Toon:');
        console.error(err);
      },
    });

    this.toonService.indexNetworks().subscribe({
      next: (data) => {
        this.networks = data;
      },
      error: (err) => {
        console.error('ToonListComponent.reload(): error loading Toon:');
        console.error(err);
      },
    });

    this.toonService.indexRatings().subscribe({
      next: (data) => {
        this.ratings = data;
      },
      error: (err) => {
        console.error('ToonListComponent.reload(): error loading Toon:');
        console.error(err);
      },
    });
  }

  loadSelectedToonMedia(cid: number) {
    this.toonService.toonMedia(cid).subscribe({
      next: (data) => {
        this.toonMedia = data;
      },
      error: (err) => {
        console.error('ToonListComponent.reload(): error loading Toon:');
        console.error(err);
      },
    });
  }

  loadSelectedToonMerch(cid: number) {
    this.toonService.toonMerch(cid).subscribe({
      next: (data) => {
        this.toonMerch = data;
      },
      error: (err) => {
        console.error('ToonListComponent.reload(): error loading Toon:');
        console.error(err);
      },
    });
  }

  getNumOfToons() {
    return this.toons.length;
  }

  displayToon(toon: Toon) {
    console.log(toon);
    console.log(this.selected);
    if(this.selected === toon){
      this.selected = null
      this.toonMedia = [];
      this.toonMerch = [];
    } else{
      this.selected = toon;
      this.loadSelectedToonMedia(toon.id);
      this.loadSelectedToonMerch(toon.id);
    }
    console.log(this.selected);
  }

  displayTable() {
    this.selected = null;
  }

  addToon() {
    this.toonService.create(this.newToon).subscribe({
      next: (data) => {
        this.newToon = new Toon();
        this.reload();
      },
      error: (err) => {
        console.error('ToonComponent.create(): error creating Toon:');
        console.error(err);
      },
    });
  }

  addMedia() {
    if(this.selected){
      this.newMedia.cartoon = this.selected;
    }
    this.mediaService.create(this.newMedia).subscribe({
      next: (data) => {
        this.newMedia = new Media();
        if(this.selected){
          this.loadSelectedToonMedia(this.selected.id);
        }
        this.reload();
      },
      error: (err) => {
        console.error('ToonComponent.create(): error creating media:');
        console.error(err);
      },
    });
  }

  addMerch() {
    if(this.selected){
      this.newMerch.cartoon = this.selected;
    }
    this.merchService.create(this.newMerch).subscribe({
      next: (data) => {
        if(this.selected){
          this.loadSelectedToonMerch(this.selected.id);
        }
        this.newMerch = new Merch();
        this.reload();
      },
      error: (err) => {
        console.error('ToonComponent.create(): error creating merch:');
        console.error(err);
      },
    });
  }

  setEditToon() {
    this.editToon = Object.assign({}, this.selected);
  }

  updateToon() {
    console.log(this.editToon);

    if(this.editToon){
      this.toonService.update(this.editToon).subscribe({
        next: (data) => {
          this.selected = data;
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

  getLoggedInUser(){
    this.authService.getLoggedInUser().subscribe({
      next: (data) => {
        this.loggedInUser = data;
        console.log(this.loggedInUser);
      },
      error: (err) => {
        console.error('ToonListComponent.updateToon(): error updating Toon:');
        console.error(err);
      },
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

  initializeSlider() {
    this.totalPages = Math.ceil(this.totalCards / this.cardsPerPage);
    this.overflowWidth = `calc(${this.totalPages * 100}% + ${this.totalPages *
      10}px)`;
    this.cardWidth = `calc((${100 / this.totalPages}% - ${this.cardsPerPage *
      10}px) / ${this.cardsPerPage})`;
  }

  getCardsPerPage() {
    return Math.floor(this.container.nativeElement.offsetWidth / 200);
  }

  changePage(incrementor: number) {
    this.currentPage += incrementor;
    this.populatePagePosition();
  }

  populatePagePosition() {
    this.pagePosition = `calc(${-100 * (this.currentPage - 1)}% - ${10 *
      (this.currentPage - 1)}px)`;
  }
}
