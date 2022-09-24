import { Merch } from '../../models/merch';
import { MerchService } from './../../services/merch.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';


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

  constructor(private route: ActivatedRoute,
    private router: Router,
    private merchServ: MerchService) { }

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

    viewDetails(selectedMerch : Merch) {
      this.selected = selectedMerch;
    }


    createMerch(newMats : Merch) {
      this.merchServ.create(newMats).subscribe (
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

}
