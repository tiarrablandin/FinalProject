import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Merch } from '../models/merch';
import { Toon } from '../models/toon';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MerchService {
  private url = environment.baseUrl + 'api/merch';

  constructor(
    private http: HttpClient,
    private auth : AuthService) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }


  index(): Observable<Merch[]> {
    return this.http.get<Merch[]>(this.url ).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MerchService.index(): error retrieving merch: ' + err)
        );
      })
    );
  }

  listUserMerch(userId : number) {
    return this.http.get<Merch[]>(environment.baseUrl + `api/users/${userId}/merch`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MerchService.index(): error retrieving Merch List: ' + err)
        );
      })
    );
  }

  create(merch: Merch): Observable<Merch> {
    return this.http.post<Merch>(environment.baseUrl + "api/" + merch.cartoon.id + "/merch", merch, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
           () => new Error( 'MerchService.create(): error creating Merch: ' + err )
        );
      })
    );
  }

  update(merch: Merch) {

    return this.http.patch<Merch>(this.url + '/' +merch.cartoon.id + '/merch/' + merch.id, merch, this.getHttpOptions()).pipe(

      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
            'MerchService.update():error updating Merch: ' + err
          )
        );
      })
     );
  }

  destroy(id: number) {
    return this.http.delete<void>(this.url + '/' + id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
            'MerchService.destroy():error deleting Merch: ' + err
          )
        );
      })
     );
  }

}

