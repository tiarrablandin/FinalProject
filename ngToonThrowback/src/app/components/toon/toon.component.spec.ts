import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ToonComponent } from './toon.component';

describe('ToonComponent', () => {
  let component: ToonComponent;
  let fixture: ComponentFixture<ToonComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ToonComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ToonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
