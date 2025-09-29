extends Node
class_name NodeUtils

static func get_all_node2d_children_recursive(parent_node: Node, found_nodes: Array[Node2D] = []) -> Array[Node2D]:
	for child in parent_node.get_children():
		if child is Node2D:
			found_nodes.append(child)
		get_all_node2d_children_recursive(child, found_nodes)
	return found_nodes
