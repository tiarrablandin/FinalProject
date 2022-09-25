import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private url = environment.baseUrl + 'api';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
    private auth: AuthService
  ) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error('UserService.index(): error retrieving user list');
        return throwError(
          () =>
            new Error('UserService.index(): error retrieving user list: ' + err)
        );
      })
    );
  }

  show(userId: any): Observable<User> {
    return this.http
      .get<User>(this.url + '/' + userId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error('UserService.show(): error retrieving User');
          return throwError(
            () => new Error('UserService.show(): error retrieving User: ' + err)
          );
        })
      );
  }

}
