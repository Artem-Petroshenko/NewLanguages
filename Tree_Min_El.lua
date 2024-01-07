Node = {value = nil, left = nil, right = nil}

function createNode(value)
    local newNode = {}
    newNode.value = value
    newNode.left = nil
    newNode.right = nil
    return newNode
end

function insert(root, value)
    if root == nil then
        return createNode(value)
    end

    if value < root.value then
        root.left = insert(root.left, value)
    elseif value > root.value then
        root.right = insert(root.right, value)
    end

    return root
end

function findMinWithPath(root, path)
    if root == nil then
        return nil, path
    end

    local current = root
    while current.left ~= nil do
        table.insert(path, current.value)
        current = current.left
    end

    table.insert(path, current.value)
    
    return current.value, path
end

local treeRoot = nil

treeRoot = insert(treeRoot, 5)
treeRoot = insert(treeRoot, 3)
treeRoot = insert(treeRoot, 8)
treeRoot = insert(treeRoot, 2)
treeRoot = insert(treeRoot, 4)

local path = {}
local minElement, path = findMinWithPath(treeRoot, path)

if minElement then
    print("Minimum element in the tree: " .. minElement)
    print("Path to the minimum element: " .. table.concat(path, " -> "))
else
    print("Tree is empty")
end
