from pathlib import Path

from poet.poet import make_graph
from jinja2 import Environment, FileSystemLoader

if __name__ == "__main__":
    package = "bumgr"
    nodes = make_graph(package)
    _cwd = Path(__file__).parent

    env = Environment(trim_blocks=True, loader=FileSystemLoader(_cwd))
    template = env.get_template("bumgr-template.rb")
    # Remove bumgr from nodes and get
    bumgr_resource = nodes.pop("bumgr")

    print(template.render(bumgr=bumgr_resource, resources=nodes.values()))
