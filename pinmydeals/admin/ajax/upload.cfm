<cfscript>
	// If the file is being uploaded as a single upload, the FORM post will contain the fields,
	// "name" and "file," which will contain the contents of the upload.
	// --
	// If the file is being uploaded in chunks, then each FORM post will contain the fields,
	// "chunks", "chunk", "name", and "file". In this case, the "file" contains the content
	// of the current chunk.


	// We are executing a normal upload (ie, the entire file at once).
	if ( isNull( form.chunks ) ) {
		fileMove(
			form.file,
			expandPath( "#APPLICATION.absoluteUrlWeb#images/uploads/#folder#/#form.name#" )
		);
	// We are executing a chunked upload.
	} else {

		// Since we are dealing with chunks, instead of a full file, we'll be appending each
		// chunk to the known file. However, for the demo, let's keep the transient file out
		// of the uploads until the chunking has been completed.
		upload = fileOpen( expandPath( "#APPLICATION.absoluteUrlWeb#images/chunks/#folder#/#form.name#" ), "append" );

		// Append the current chunk to the end of the transient file.
		fileWrite( upload, fileReadBinary( form.file ) );
		fileClose( upload );

		// If this is the last of the chunks, the we can move the transient file to the
		// completed uploads folder (with a unique name).
		if ( form.chunk == ( form.chunks - 1 ) ) {
			fileMove(
				expandPath( "#APPLICATION.absoluteUrlWeb#images/chunks/#folder#/#form.name#" ),
				expandPath( "#APPLICATION.absoluteUrlWeb#images/uploads/#folder#/#form.name#" )
			);
		}
	}

</cfscript>

<!--- Reset the content buffer. --->
<cfcontent
	type="text/plain"
	variable="#charsetDecode( 'success', 'utf-8' )#"
	/>