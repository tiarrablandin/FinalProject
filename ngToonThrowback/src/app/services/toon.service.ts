import { Toon } from './../models/toon';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { catchError, throwError } from 'rxjs';
import { Media } from '../models/media';

@Injectable({
  providedIn: 'root',
})
export class ToonService {
  private url = environment.baseUrl + 'api/cartoons';

  constructor(private http: HttpClient, private auth: AuthService) {}

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
    return this.http.post<Toon>(this.url, toon).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.create(): error creating Toon: ' + err)
        );
      })
    );
  }

  update(toon: Toon) {
    return this.http.put<Toon>(this.url + '/' + toon.id, toon).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.update(): error updating Toon: ' + err)
        );
      })
    );
  }

  destroy(id: number) {
    return this.http.delete<Toon>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('ToonService.destroy(): error deleting Toon: ' + err)
        );
      })
    );
  }
}
