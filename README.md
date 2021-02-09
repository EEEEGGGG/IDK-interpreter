# IDK-interpreter
## Usage
<table>
<thead>
	<tr>
		<th>Short Option</th>
		<th>Long Option</th>
		<th>Description</th>
		<th>Notes</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>
			<code>-h</code>
		</td>
		<td>
			<code>--help</code>
		</td>
		<td>Show help page</td>
		<td>Running help page first before other options will cancel it.</td>
	</tr>
	<tr>
		<td>
			<code>-s</code>
		</td>
		<td>
			<code>--stdin</code>
		</td>
		<td>Run program from stdin</td>
		<td>You can set this option multiple times</td>
	</tr>
	<tr>
		<td>
			<code>-f</code>
		</td>
		<td>
			<code>--files</code>
		</td>
		<td>Run program from file</td>
		<td>You can set this option multiple times</td>
	</tr>
	<tr>
		<td>
			<code>-d</code>
		</td>
		<td>
			<code>--debug</code>
		</td>
		<td>Debug file or stdin</td>
		<td>
			Debug on a file or stdin.
			<br>
			Running this option without any level will set the defualt to 1.
			<br>
			<table>
			<thead>
				<tr>
					<th>Debug Level</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>Enables debugging, outputs tokens, BOF, EOF, stack.</td>
				</tr>
				<tr>
					<td>2</td>
					<td>
						sets <code>set -xv</code> in bash
					</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Both 1 and 2</td>
				</tr>
			</tbody>
			</table>
		</td>
	</tr>

</tbody>
</table>
