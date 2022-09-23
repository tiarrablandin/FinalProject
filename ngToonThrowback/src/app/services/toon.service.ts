import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ToonService {
  private url = environment.baseUrl + 'api/cartoons';

  constructor( private http: HttpClient,
    private datePipe: DatePipe,
    private auth: AuthService) { }
}
