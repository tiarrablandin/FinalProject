import { Comment } from './../models/comment';
import { Toon } from './../models/toon';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { catchError, throwError } from 'rxjs';
import { Media } from '../models/media';
import { Merch } from '../models/merch';
import { Network } from '../models/network';
import { Rating } from '../models/rating';

@Injectable({
  providedIn: 'root',
})
export class ToonService {
  private url = environment.baseUrl + 'api/cartoons';

  constructor(private http: HttpClient, private auth: AuthService) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index() {
    return this.http.get<Toon[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Toon List: ' + err)
        );
      })
    );
  }

  indexNetworks() {
    return this.http.get<Network[]>(this.url + "/networks").pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Toon List: ' + err)
        );
      })
    );
  }

  indexRatings() {
    return this.http.get<Rating[]>(this.url + "/ratings").pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Toon List: ' + err)
        );
      })
    );
  }

  toonMedia(cid: number) {
    return this.http.get<Media[]>(this.url + "/" + cid + "/media").pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Media List: ' + err)
        );
      })
    );
  }

  toonMerch(cid: number) {
    return this.http.get<Merch[]>(this.url + "/" + cid + "/merch").pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Merch List: ' + err)
        );
      })
    );
  }

  listUserCartoons(userId : number) {
    return this.http.get<Toon[]>(environment.baseUrl + `api/users/${userId}/cartoons`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving Toon List: ' + err)
        );
      })
    );
  }
  listComments(cid : number) {
    return this.http.get<Comment[]>(environment.baseUrl + `api/cartoons/${cid}/comments`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'CommentService.index(): error retrieving Comment List: ' + err
            )
        );
      })
    );
  }


  // listComments() {
  //   return this.http.get<Toon[]>(environment.baseUrl + `api/cartoons/comments`).pipe(
  //     catchError((err: any) => {
  //       console.log(err);
  //       return throwError(
  //         () =>
  //           new Error('ToonService.index(): error retrieving Toon List: ' + err)
  //       );
  //     })
  //   );
  // }


  search(searchTerm: string) {
    return this.http.get<Toon[]>(this.url + '/search/' + searchTerm).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('ToonService.index(): error retrieving cartoon: ' + err)
        );
      })
    );
  }

  create(toon: Toon) {
    return this.http.post<Toon>(this.url, toon, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.create(): error creating Toon: ' + err)
        );
      })
    );
  }

  update(toon: Toon) {
    return this.http.put<Toon>(this.url + '/' + toon.id, toon, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.update(): error updating Toon: ' + err)
        );
      })
    );
  }

  destroy(id: number) {
    return this.http.delete<Toon>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.destroy(): error deleting Toon: ' + err)
        );
      })
    );
  }
}
