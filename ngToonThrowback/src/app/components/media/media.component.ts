import { MediaService } from './../../services/media.service';
import { Component, OnInit } from '@angular/core';
import { Media } from 'src/app/models/media';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-media',
  templateUrl: './media.component.html',
  styleUrls: ['./media.component.css']
})
export class MediaComponent implements OnInit {

  selected: Media | null = null;

  newMedia: Media = new Media();

  editMedia: Media | null = null;

  medias: Media[] = [];
  closeResult: string = '';

  constructor(private mediaService: MediaService, private modalService: NgbModal) { }

  ngOnInit(): void {
    this.reload();
  }


  reload() {
    this.mediaService.index().subscribe(
    {
      next: (data) => {
        this.medias = data
      },
      error: (err) => {
        console.error('MediaListComponent.reload(): error loading media:');
        console.error(err);
      }
    }
    );
  }



  getNumOfMedias() {
    return this.medias.length;

  }

  displayMedia(media: Media) {
  this.selected = media;
  }

  displayTable() {
    this.selected = null;
  }
addMedia() {
this.mediaService.create(this.newMedia).subscribe(
  {
    next: (data) => {
      this.newMedia = new Media();
      this.reload();
    },
    error: (err) => {
      console.error('MediaComponent.create(): error creating media:');
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



setEditMedia() {
  this.editMedia = Object.assign({}, this.selected);
}

updateMedia(updatedMedia: Media) {
this.mediaService.update(updatedMedia).subscribe(
  {
    next: (data) => {
      this.selected = data;
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

}
