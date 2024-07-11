import { Component, OnInit,AfterViewInit, ViewChild } from '@angular/core';
import { UntypedFormBuilder, UntypedFormGroup, Validators } from '@angular/forms';
import { AlertifyService } from 'app/core/services/alertify.service';
import { LookUpService } from 'app/core/services/lookUp.service';
import { AuthService } from 'app/core/components/admin/login/services/auth.service';
import { LogDto } from './models/LogDto';
import { LogDtoService } from './services/LogDto.service';
import { Subject } from 'rxjs/Rx';
import { MatLegacyTableDataSource as MatTableDataSource } from '@angular/material/legacy-table';
import { MatLegacyPaginator as MatPaginator } from '@angular/material/legacy-paginator';
import { MatSort } from '@angular/material/sort';


declare var jQuery: any;

@Component({
	selector: 'app-logDto',
	templateUrl: './logDto.component.html',
	styleUrls: ['./logDto.component.scss']
})
export class LogDtoComponent implements AfterViewInit, OnInit {

	dataSource: MatTableDataSource<any>;
	@ViewChild(MatPaginator) paginator: MatPaginator;
	@ViewChild(MatSort) sort: MatSort;
	displayedColumns: string[] = ['id', 'level', 'exceptionMessage','timeStamp','user','value','type'];	


	logDtoList: LogDto[];
	logDto: LogDto = new LogDto();

	logDtoAddForm: UntypedFormGroup;

	logDtoId: number;
	dtTrigger: Subject<any> = new Subject<any>();

	constructor(private logDtoService: LogDtoService, private lookupService: LookUpService, private alertifyService: AlertifyService, private formBuilder: UntypedFormBuilder, private authService: AuthService) { }

	ngOnInit() {

		this.getLogDtoList();
	}

	getLogDtoList() {
		this.logDtoService.getLogDtoList().subscribe(data => {
			this.logDtoList = data;
			this.dataSource = new MatTableDataSource(data);
			this.configDataTable();
		});
	}

	ngOnDestroy(): void {
		this.dtTrigger.unsubscribe();
	}

	ngAfterViewInit(): void {
		this.getLogDtoList();
	}

	clearFormGroup(group: UntypedFormGroup) {

		group.markAsUntouched();
		group.reset();

		Object.keys(group.controls).forEach(key => {
			group.get(key).setErrors(null);
			if (key == 'id')
				group.get(key).setValue(0);
		});
	}

	checkClaim(claim: string): boolean {
		return this.authService.claimGuard(claim)
	}

	configDataTable(): void {
		this.dataSource.paginator = this.paginator;
		this.dataSource.sort = this.sort;
	
	  }

	  applyFilter(event: Event) {
		const filterValue = (event.target as HTMLInputElement).value;
		this.dataSource.filter = filterValue.trim().toLowerCase();

		if (this.dataSource.paginator) {
			this.dataSource.paginator.firstPage();
		}
	}

}
