from collections import namedtuple
from lxml import etree

Selectors = namedtuple('Selectors', ['tags', 'classes', 'ids'])

def get_possible_selectors(file_name):
    parser = etree.HTMLParser()
    with open(file_name) as f:
        tree = etree.parse(f, parser)

    body = tree.find('body')

    all_tags = set()
    all_classes = set()
    all_ids = set()

    for e in body.getiterator():
        all_tags.add(e.tag)

        if e.get('id'):
            all_ids.add(e.get('id'))

        if e.get('class'):
            classes = e.get('class').split()
            all_classes.update(classes)

    return Selectors(all_tags, all_classes, all_ids)

def selectors_to_file(selectors, file_name):
    with open(file_name, 'w') as f:
        for t in selectors.tags:
            f.write(t + '\n')

        for c in selectors.classes:
            f.write('.' + c + '\n')

        for i in selectors.ids:
            f.write('#' + i + '\n')

if __name__ == "__main__":
    selectors = get_possible_selectors('index.html')
    selectors_to_file(selectors, 'selectors.txt')
