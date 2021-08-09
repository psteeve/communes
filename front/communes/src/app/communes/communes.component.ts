import { Component, Input, OnInit } from '@angular/core';
import { Commune } from 'src/core/communes';

@Component({
  selector: 'app-communes',
  templateUrl: './communes.component.html',
  styleUrls: ['./communes.component.css']
})
export class CommunesComponent implements OnInit {

  @Input() communes: ReadonlyArray<Commune> | null = [];
  
  constructor() { }

  ngOnInit(): void {
    console.log(this.communes);
  }

}
