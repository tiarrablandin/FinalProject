import { Trivia } from './../models/trivia';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Media } from '../models/media';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TriviaService {
  private url = environment.baseUrl;


  constructor(private http: HttpClient,
    private auth: AuthService) { }

  index() {
    return this.http.get<Trivia[]>(environment.baseUrl + "api/trivia").pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error (
            'TriviaService.index(): error retrieving Trivia List: ' + err
          )
        )
      }
      )
      )
  }

  create(trivia: Trivia) {
    return this.http.post<Trivia>(this.url, trivia).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error (
            'TriviaService.create(): error creating Trivia: ' + err
          )
        );
      })
    );
  }

  update(trivia: Trivia) {
    return this.http.put<Trivia>(this.url + '/' + trivia.id, trivia).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error (
            'TriviaService.update(): error updating Trivia: ' + err
          )
        );
      })
    );
  }

  destroy(id: number) {
    return this.http.delete<Trivia>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error (
            'TriviaService.destroy(): error deleting Trivia: ' + err
          )
        );
      })
    );
  }

}
