$(function(){
	var moveUp = function(){
		//�����ƶ�����Ŀ
		var link = $(this),
			dl = link.parents("dl"),
			prev = dl.prev("dl");	
		if(link.is(".up") && prev.length > 0)
			dl.insertBefore(prev);
	};
	
	var addItem = function(){
		//���һ������Ŀ
		var sortable = $(this).parents(".ui-sortable");
		var options = '<span class="options"><a class="up"><img src="up.gif" border="0"></a></span>';
		var html = '<dl class="sort"><dt>Dynamic name'+options+'</dt><dd>Description</dd></dl>';
		sortable.append(html).sortable("refresh").find("a.up").bind("click", moveUp);
	};
	
	var emptyTrashCan = function(item){
		//����վ
		item.remove();
	};
	
	var sortableChange = function(e, ui){
		//��ק����Ŀ
		if(ui.sender){
			var w = ui.element.width();
			ui.placeholder.width(w);
			ui.helper.css("width",ui.element.children().width());
		}
	};
	
	var sortableUpdate = function(e, ui){
		//����ģ�飨�û�����վ��պ�
		if(ui.element[0].id == "trashcan"){
			emptyTrashCan(ui.item);
		}
	};
	
	$(function(){
		//������ҳ���е����п�
		var els = ['#header', '#content', '#sidebar', '#footer', '#trashcan'];
		var $els = $(els.toString());
		
		//��̬��ӡ���������Ŀ�����������ƶ�����ť
		$("h2", $els.slice(0,-1)).append('<span class="options"><a class="add"><img src="add.gif" border="0"></a></span>');
		$("dt", $els).append('<span class="options"><a class="up"><img src="up.gif" border="0"></a></span>');
		
		//������¼�
		$("a.add").bind("click", addItem);
		$("a.up").bind("click", moveUp);
		
		//ʹ��jQuery���
		$els.sortable({
			items: '> dl',	//��ק����
			handle: 'dt',	//�ɴ������¼��Ķ���
			cursor: 'move',	//�����ʽ
			opacity: 0.8,	//��קʱ͸��
			appendTo: 'body',
			connectWith: els,
			start: function(e,ui) {
				ui.helper.css("width", ui.item.width());
			},
			change: sortableChange,
			update: sortableUpdate		//���ڻ���վ
		});
	});
});