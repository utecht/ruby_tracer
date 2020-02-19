require 'matrix'

Given('the following {int}x{int} matrix M:') do |width, height, table|
  @table = Matrix.from_data_table(table.raw)
end

Then('M[{int},{int}] = {float}') do |x, y, float|
  expect(@table[x, y]).to eq float
end

Given('the following matrix A:') do |table|
  @a = Matrix.from_data_table(table.raw)
end

Given('the following matrix B:') do |table|
  @b = Matrix.from_data_table(table.raw)
end

Then('A = B') do
  expect(@a).to eq @b
end

Then('A != B') do
  expect(@a).not_to eq @b
end

Then('A * B is the following 4x4 matrix:') do |table|
  expect(@a * @b).to eq Matrix.from_data_table(table.raw)
end

Then('B * a = tuple\({float}, {float}, {float}, {float})') do |x, y, z, w|
  expect(@b * @a).to eq Tuple.new(x, y, z, w)
end

Then('A * identity_matrix = A') do
  expect(@a * Matrix.identity).to eq @a
end

Then('identity_matrix * a = a') do
  expect(Matrix.identity * @a).to eq @a
end

Then('transpose\(A) is the following matrix:') do |table|
  @a = Matrix.from_data_table(table.raw).transpose
end

Given('A ← transpose\(identity_matrix)') do
  @a = Matrix.identity.transpose
end

Then('A = identity_matrix') do
  expect(@a).to eq Matrix.identity
end

Given('the following {int}x{int} matrix A:') do |w, h, table|
  @a = Matrix.from_data_table(table.raw)
end

Then('determinant\(A) = {float}') do |float|
  expect(@a.determinant).to eq float
end


Then('submatrix\(A, {int}, {int}) is the following {int}x{int} matrix:') do |row, col, int3, int4, table|
  expect(@a.submatrix(row, col)).to eq Matrix.from_data_table(table.raw)
end

Given('B ← submatrix\(A, {int}, {int})') do |row, col|
  @b = @a.submatrix(row, col)
end

Then('determinant\(B) = {float}') do |float|
  expect(@b.determinant).to eq float
end

Then('minor\(A, {int}, {int}) = {float}') do |row, col, float|
  expect(@a.minor(row, col)).to eq float
end

Then('cofactor\(A, {int}, {int}) = {float}') do |row, col, float|
  expect(@a.cofactor(row, col)).to eq float
end

Then('A is invertible') do
  expect(@a.invertable?).to be true
end

Then('A is not invertible') do
  expect(@a.invertable?).to be false
end

Given('B ← inverse\(A)') do
  @b = @a.inverse
end

Then('B[{int},{int}] = {float}\/{float}') do |x, y, float, float2|
  expect(@b[x, y]).to eq float/float2
end

Then('B is the following 4x4 matrix:') do |table|
  @b = Matrix.from_data_table(table.raw)
end

Then('inverse\(A) is the following 4x4 matrix:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  expect(@a.inverse).to eq Matrix.from_data_table(table.raw)
end

Given('C ← A * B') do
  @c = @a * @b
end

Then('C * inverse\(B) = A') do
  expect(@c * @b.inverse).to eq @a
end
