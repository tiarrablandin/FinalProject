import { Toon } from './../../models/toon';
import { Component, OnInit } from '@angular/core';
import { ToonService } from 'src/app/services/toon.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-toon',
  templateUrl: './toon.component.html',
  styleUrls: ['./toon.component.css'],
})
export class ToonComponent implements OnInit {

  selected: Toon | null = null;
  newToon: Toon = new Toon();
  editToon: Toon | null = null;
  toons: Toon[] = [];

  constructor(
    private toonService: ToonService,
    private currentRoute: ActivatedRoute
  ) {}

  ngOnInit(): void {
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
  }

  getNumOfToons() {
    return this.toons.length;
  }

  displayToon(toon: Toon) {
    console.log(toon);
    console.log(this.selected);
    if(this.selected === toon){
      this.selected = null
    } else{
      this.selected = toon;
    }
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

  setEditToon() {
    this.editToon = Object.assign({}, this.selected);
  }

  updateToon(updatedToon: Toon) {
    this.toonService.update(updatedToon).subscribe({
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
}
