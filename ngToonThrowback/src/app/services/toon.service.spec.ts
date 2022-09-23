import { TestBed } from '@angular/core/testing';

import { ToonService } from './toon.service';

describe('ToonService', () => {
  let service: ToonService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ToonService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
