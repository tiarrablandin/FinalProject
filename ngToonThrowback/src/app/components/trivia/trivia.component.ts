import { Trivia } from './../../models/trivia';
import { TriviaService } from './../../services/trivia.service';
import { Component, OnInit } from '@angular/core';
import { popper } from '@popperjs/core';

@Component({
  selector: 'app-trivia',
  templateUrl: './trivia.component.html',
  styleUrls: ['./trivia.component.css']
})
export class TriviaComponent implements OnInit {



  selected: Trivia | null = null;

  newTrivia: Trivia = new Trivia();

  editTrivia: Trivia | null = null;

  trivias: Trivia[] = [];

  constructor(private triviaService: TriviaService) { }


  ngOnInit(): void {
    this.reload();
  }


  reload() {
    this.triviaService.index().subscribe(
    {
      next: (data) => {
        this.trivias = data
      },
      error: (err) => {
        console.error('TriviaListComponent.reload(): error loading Trivia:');
        console.error(err);
      }
    }
    );
  }



  getNumOfTrivia() {
    return this.trivias.length;

  }

  displayTrivia(trivia: Trivia) {
  this.selected = trivia;
  }

  displayTable() {
    this.selected = null;
  }
addTrivia() {
this.triviaService.create(this.newTrivia).subscribe(
  {
    next: (data) => {
      this.newTrivia = new Trivia();
      this.reload();
    },
    error: (err) => {
      console.error('TriviaComponent.create(): error creating Trivia:');
      console.error(err);
    }
  }
);


}



setEditTrivia() {
  this.editTrivia = Object.assign({}, this.selected);
}

updateTrivia(updatedTrivia: Trivia) {
this.triviaService.update(updatedTrivia).subscribe(
  {
    next: (data) => {
      this.selected = data;
      this.editTrivia = null;
      this.reload();
    },
    error: (err) => {
      console.error('TriviaListComponent.updateTrivia(): error updating Trivia:');
      console.error(err);
    }
  }
);
}

deleteTrivia(id: number) {
this.triviaService.destroy(id).subscribe(
  {
    next: () => {
      this.reload();
    },
    error: (err) => {
      console.error('TriviaListComponent.deleteTrivia(): error deleting Trivia:');
      console.error(err);
    }
  }
);
}
}

