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

  public communeSubscription: Subscription = null as unknown as Subscription;

  constructor() {

    this.global = window as unknown as Record<string, any>;
    this.global.communes = communes;
  }

  ngOnInit() {

  }

  ngOnDestroy() {
    this.communeSubscription?.unsubscribe();
  }

  public getCommunes(search: string) {
    return from(communes(search));
  }

  onSearchCommunes(value: any) {
    if (value?.isTrusted || value === '') {
      return;
    }
    
    this.communeSubscription = this.getCommunes(value).
      pipe(tap(data => {
        this.communes$.next(data);
      }))
      .subscribe();
  }

}
