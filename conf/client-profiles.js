db.entity.update({'ident':'client1'}, {'$set':
    {
    	'cmpnm': 'eZuce',
	    'avt': 'https://www.ezuce.com/image/image_gallery?uuid=1b05c8e7-63b9-49cd-bdd5-78f263763f0f&groupId=10458&t=1288976338344',
	    'ostr': '300 Brickstone Square',
	    'octy': 'Andover',
	    'ocntry': 'USA',
	    'ostate': 'MA',
	    'ozip': '01810',
	    'odsgn': 'Office designation',
	    'cmpph': '978-296-1005',
	    'cmpfax': '978-296-1006',

	    'ctcnm': 'Contact name',
	    'ctcjb': 'Contact job',
	    'ctcwph': 'Contact work number',
	    'ctccell': 'Contact cell',
	    'ctcemail': 'Contant email',

	    'astnm': 'Assistant name',
	    'astph': 'Assistant phone',
	    'astemail': 'Assistant e-mail',
	    'urlpop': 'http://company.salesforce.com/calls?callid=#{callid}&client=#{client}'
	}
});