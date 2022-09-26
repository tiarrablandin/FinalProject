import { AuthService } from 'src/app/services/auth.service';
import { Toon } from './../../models/toon';
import { Merch } from '../../models/merch';
import { MerchService } from './../../services/merch.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';


@Component({
  selector: 'app-merch',
  templateUrl: './merch.component.html',
  styleUrls: ['./merch.component.css']
})
export class MerchComponent implements OnInit {

  // title = 'ngMerch';

  merchs: Merch[] = [];


  selected: Merch | null = null;
  newMerch: Merch = new Merch();
  editMerch: Merch | null = null;
  addMerch: Merch | null = null;
  indexToon: Toon = new Toon();
  closeResult: string = '';

  constructor(private route: ActivatedRoute,
    private router: Router,
    private merchServ: MerchService,
    private auth: AuthService,
    private modalService: NgbModal) { }

    ngOnInit(): void {
      this.loadMerch();
    }

    loadMerch(): void {
      this.merchServ.index().subscribe(
        {
          next: (merchs) => {
            this.merchs = merchs;
          },
          error: (problem) => {
            console.error('MerchListHttpComponent.loadMerchs(): error loading merchs:');
            console.error(problem);
          }
        }
      );
    }

    // viewDetails(selectedMerch : Merch) {
    //   this.selected = selectedMerch;
    // }


    createMerch(newMerch : Merch) {
      this.merchServ.create(newMerch).subscribe (
        {
          next: (data) => {
          this.loadMerch();
          this.newMerch = new Merch();
          },
          error: (err) => {
            console.log(err);
          }
        }
      )
    }

    reload() {
      this.merchServ.index().subscribe({
        next: (merchs) => {
          this.merchs = merchs;
        },
        error: (err) => {
          console.error('MatsuriListComponent.reload(): error retrieving matsuris');
          console.error(err);
        },
      });
    }

    updateMerch(merch: Merch, setSelected = true): void {
      this.merchServ.update(merch).subscribe({
        next: (merch) => {
          this.reload();

          if (setSelected) {
            this.selected = merch;
          }
        },
        error: (bad) => {
          console.error('MerchListComponent.updateMerch(): error updating merch');
          console.error(bad);
        },
      });
    }

    deleteMerch(id: number): void {
      this.merchServ.destroy(id).subscribe({
        next: (good) => {
          this.reload();
        },
        error: (bad) => {
          console.error('MerchListComponent.deleteMerch(): error deleting merch');
          console.error(bad);
        },
      });
    }

    setEditMerch(): void {
      this.editMerch = Object.assign({}, this.selected);

    }

      loggedIn() {
        return this.auth.checkLogin();
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


    // setAddMerch(): void {
    //   this.addMerch = Object.assign({}, this.selected);
    // }
}
