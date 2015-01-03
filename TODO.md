* TODO [2015-01-03 Sat] periahs: peri-htserve: Pass more Plackup options.
* TODO [2015-01-03 Sat] periahs: peri-htserve: Pass more PSGI server options.
* TODO [2014-10-30 Thu] periahs: support partial input data

  - in ParseRequest middleware, check Content-Range HTTP req header and set
    arg_{len,part_start,part_len} Riap request keys
  - in Respond, when calling riap client, pass it to client
* TODO [2014-10-30 Thu] periahs: support partial result

  - pass HTTP Range (request range to server) to Riap request keys:
    res_part_{start,len}
  - translate result metadata property len, part_start, part_len to
* TODO [2014-10-30 Thu] periahs: support streaming input

  - dengan membaca request client dengan header Transfer-Encoding: chunked, lalu
    call function, dengan nilai argumen adalah objek yang dapat menerima method
    get() utk get data. method ini akan membaca psgi.in for more data (more
    chunks) dan baru undef jika dapat chunk dengan size 0 (yang berarti chunked
    transfer berakhir).
* TODO [2014-10-30 Thu] periahs: support streaming output

  - fungsi menghasilkan [200, OK, $fh, {stream=>1}]. ini ditranslate oleh server
    dengan return satu chunk dulu (dengan some marker?) [200, OK, "stream",
    {stream=>1}] lalu di chunk2x berikutnya mengirimkan data stream. riap::http
    client akan menerjemahkan "stream" menjadi objek yang dapat dipanggil utk get
    more data from chunk responses.
  - note: chunked transfer juga digunakan oleh logging, jangan sampe bentrok.
* TODO [2014-09-11 Thu] periahs: when logging, redact function arguments which has is_password property value of true
