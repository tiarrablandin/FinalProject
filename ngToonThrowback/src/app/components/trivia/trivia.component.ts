import { Trivia } from './../../models/trivia';
import { TriviaService } from './../../services/trivia.service';
import { Component, OnInit } from '@angular/core';
import { popper } from '@popperjs/core';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';

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

  closeResult: string = '';

  constructor(private triviaService: TriviaService,
    private modalService: NgbModal) { }


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


open(content: any ) {
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

