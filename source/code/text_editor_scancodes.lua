
-- for key = 1,#__lua_keys do
--     local keyword,j = __lua_keys[key],1
    
--     while j < #line do
--         local pos = substr(newline,keyword,j)
--         j += 1

--         if pos then
--             j = max(j,#keyword+pos)
--             newline = insert(newline,pos-1,__token_col_key)
--             newline = insert(newline,#keyword+pos+1,__token_col_normal)
--         end
--     end
-- end