Ext.onReady(function(){
	var myData = [
		['��Ӧ��','XX��Ӧ��'],
		['�ͻ�','XX������'],
		['','test']
		];
	var store = new Ext.data.SimpleStore({fields : [
		{name:'CustType'},
		{name:'CustName'}
		],
	data:myData
	});
	var grid = new Ext.grid.GridPanel({
		store:store,
		cloumns:[
			{header:'��λ���',dataIndex:'CustType'},
			{header:'��˾����',dataIndex:'CustName'}
		],
		title:'Test'
	});
	grid.render(document.body);
});