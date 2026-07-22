
page_multiple_alignment.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3fff            // =16383
               	and	x1, x0, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x4000            // =16384
               	add	x1, x1, x17
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x8000            // =32768
               	add	x1, x1, x17
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xc000            // =49152
               	add	x1, x1, x17
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x10000           // =65536
               	add	x1, x1, x17
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x1, x0, #0x1
               	mov	x17, #0x3fff            // =16383
               	and	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x17, #0x2000            // =8192
               	add	x0, x0, x17
               	mov	x17, #0x3fff            // =16383
               	and	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x16               // =22
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x4000            // =16384
               	add	x1, x1, x17
               	mov	x2, #0x21               // =33
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x4000            // =16384
               	movk	x17, #0x1, lsl #16
               	add	x1, x1, x17
               	mov	x2, #0x2c               // =44
               	str	w2, [x1]
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x4000            // =16384
               	add	x0, x0, x17
               	ldrsw	x0, [x0]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x4000            // =16384
               	movk	x17, #0x1, lsl #16
               	add	x0, x0, x17
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2c
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
