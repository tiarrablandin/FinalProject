import { MerchService } from './services/merch.service';

import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavbarComponent } from './components/navbar/navbar.component';
import { HomeComponent } from './components/home/home.component';
import { ToonService } from './services/toon.service';
import { AuthService } from './services/auth.service';
import { AccountComponent } from './components/account/account.component';
import { MediaComponent } from './components/media/media.component';
import { TriviaComponent } from './components/trivia/trivia.component';
import { MerchComponent } from './components/merch/merch.component';
import { RegisterComponent } from './components/register/register.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AboutComponent } from './components/about/about.component';


@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomeComponent,
    AccountComponent,
    MediaComponent,
    TriviaComponent,
    MerchComponent,
    RegisterComponent,
    NotFoundComponent,
    AboutComponent,
    AboutComponent,
    NotFoundComponent,
    RegisterComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule
  ],
  providers: [
    ToonService,
    MerchService,
    AuthService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
