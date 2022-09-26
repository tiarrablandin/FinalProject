import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { Component, Injectable } from '@angular/core';
import { Media } from '../models/media';
import { ngbCarouselTransitionOut } from '@ng-bootstrap/ng-bootstrap/carousel/carousel-transition';
import { environment } from 'src/environments/environment';
import { catchError, throwError } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})


export class MediaService {
private url = environment.baseUrl + "api/media";

constructor(private http: HttpClient, private auth: AuthService
 ) { }

index() {
  return this.http.get<Media[]>(this.url).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error (
          'MediaService.index(): error retrieving Media List: ' + err
        )
      )
    }
    )
    )
}

create(media: Media) {
  return this.http.post<Media>(this.url, media, this.getHttpOptions()).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error (
          'MediaService.create(): error creating Media: ' + err
        )
      );
    })
  );
}

update(media: Media) {
  return this.http.put<Media>(this.url + '/' + media.id, media).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error (
          'MediaService.update(): error updating Media: ' + err
        )
      );
    })
  );
}

destroy(id: number) {
  return this.http.delete<Media>(this.url + '/' + id).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error (
          'MediaService.destroy(): error deleting Media: ' + err
        )
      );
    })
  );
}

getHttpOptions() {
  let options = {
    headers: {
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'X-Requested-With': 'XMLHttpRequest',
    },
  };
  return options;
}


}


