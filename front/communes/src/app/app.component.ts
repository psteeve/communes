import { Component, OnDestroy, OnInit } from '@angular/core';
import { BehaviorSubject, from, Subscription } from 'rxjs';
import { tap } from 'rxjs/operators';
import { Commune, communes } from 'src/core/communes';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit, OnDestroy {
  public global: Record<string, any>;
  public communes$: BehaviorSubject<ReadonlyArray<Commune>> = new BehaviorSubject([] as ReadonlyArray<Commune>);
  
  public communeSubscription: Subscription;
  
  constructor() {

    this.global = window as unknown as Record<string, any>;
    this.global.communes = communes;

    this.communeSubscription = this.getCommunes().
    pipe(tap(data => {
      this.communes$.next(data);
    }))
    .subscribe();
  }
  
  ngOnInit() {
    
  }

  ngOnDestroy() {
    this.communeSubscription.unsubscribe();
  }

  public getCommunes() {
    return from(communes());
  }

  onSearchCommunes(value: string) {
    console.log(value);
  }
}
