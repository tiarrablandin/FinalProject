import { Comment } from './../models/comment';
import { AuthService } from 'src/app/services/auth.service';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Media } from '../models/media';

@Injectable({
  providedIn: 'root'
})
export class CommentService {
  private url = environment.baseUrl + 'api/comments';
  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }

  index() {
    return this.http.get<Comment[]>(this.url).pipe(
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

  create(comment: Comment) {
    return this.http.post<Comment>(environment.baseUrl + "api/cartoons/" + comment.cartoon.id + "/comments", comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('CommentService.create(): error creating Comment: ' + err)
        );
      })
    );
  }

  update(comment: Comment) {
    return this.http.put<Comment>(this.url + '/' + comment.id, comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('CommentService.update(): error updating Comment: ' + err)
        );
      })
    );
  }

  destroy(comment: Comment) {
    return this.http.delete<Comment>(environment.baseUrl + "api/cartoons/" + comment.id + "/comments/" +  comment.id, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CommentService.destroy(): error deleting Comment: ' + err)
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
  listUserComment(userId : number) {
    return this.http.get<Comment[]>(environment.baseUrl + `api/users/${userId}/comments`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CommentService.index(): error retrieving Comment List: ' + err)
        );
      })
    );
  }
  listComments(cid : number) {
    return this.http.get<Comment[]>(this.url + `api/cartoons/${cid}/comments`).pipe(
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
}

