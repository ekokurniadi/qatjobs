enum OrderQuery { asc, desc }

abstract class QueryBuilder {
  QueryBuilder select(List<String> columnName);
  QueryBuilder selectOne(String columnName);
  QueryBuilder selectAll();
  QueryBuilder from(String tableName);
  QueryBuilder where({
    required String columnName,
    required String operate,
    required dynamic value,
  });
  QueryBuilder and();
  QueryBuilder andWhere({
    required String columnName,
    required String operate,
    required dynamic value,
  });
  QueryBuilder orderBy({
    required String columnName,
    required OrderQuery order,
  });
  QueryBuilder order();
  QueryBuilder rawQuery(String query);
  String buildQuery();
}

/// Example usage select specific column name
/// ```sql
/// SELECT a,b,c FROM tableName 
/// WHERE a != 0 AND b != true 
/// ORDER by a,b ASC LIMIT 0,10
/// 
/// ```
/// 
/// ```dart
/// String builder = QueryBuilderImpl()
/// .select(['a,b,c'])
/// .from('tableName')
/// .where(columnName: 'a', operate: '!=', value: 0)
/// .andWhere(columnName: 'b', operate: '!=', value: true)
/// .order()
/// .orderBy(columnName: 'a,b', order: OrderQuery.asc)
/// .rawQuery('LIMIT 0,10')
/// .buildQuery();
/// ```
/// 
/// 
/// Example usage select all from the table
/// 
/// ```sql
/// SELECT * FROM users
/// ```
/// ```dart
/// String builder = QueryBuilderImpl()
/// .selectAll()
/// .from('tableName')
/// .buildQuery();
/// ```

class QueryBuilderImpl implements QueryBuilder {
  String sqlQuery = '';

  @override
  String buildQuery() {
    return sqlQuery;
  }

  @override
  QueryBuilder from(String tableName) {
    sqlQuery += ''' FROM $tableName ''';
    return this;
  }

  @override
  QueryBuilder rawQuery(String query) {
    sqlQuery += ''' $query ''';
    return this;
  }

  @override
  QueryBuilder selectAll() {
    sqlQuery += ''' SELECT * ''';
    return this;
  }

  @override
  QueryBuilder selectOne(String columnName) {
    sqlQuery += ''' SELECT $columnName ''';
    return this;
  }

  @override
  QueryBuilder and() {
    sqlQuery += ''' AND  ''';
    return this;
  }

  @override
  QueryBuilder andWhere({
    required String columnName,
    required String operate,
    required value,
  }) {
    sqlQuery += ''' AND $columnName$operate'$value' ''';
    return this;
  }

  @override
  QueryBuilder where({
    required String columnName,
    required String operate,
    required value,
  }) {
    sqlQuery += ''' WHERE $columnName$operate'$value'  ''';
    return this;
  }

  @override
  QueryBuilder select(List<String> columnName) {
    String query = '';
    String separator = '';

    for (int i = 0; i < columnName.length; i++) {
      if (columnName.length > 1) {
        if (i == columnName.length - 1) {
          separator = '';
        } else {
          separator = ',';
        }
      } else {
        separator = '';
      }

      query += ''' ${columnName[i]}$separator ''';
    }
    sqlQuery += query;
    return this;
  }

  @override
  QueryBuilder orderBy({
    required String columnName,
    required OrderQuery order,
  }) {
    final orders = order == OrderQuery.asc ? 'ASC' : 'DESC';
    sqlQuery += '''  $columnName  $orders ''';
    return this;
  }

  @override
  QueryBuilder order() {
    sqlQuery += ''' ORDER BY  ''';
    return this;
  }
}
