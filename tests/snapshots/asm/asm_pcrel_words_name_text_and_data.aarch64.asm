
asm_pcrel_words_name_text_and_data.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<fn>:
               	mov	x0, #0x3                // =3
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x0, x3
               	sub	x3, x3, x2
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x0, x3
               	sub	x3, x3, x2
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	add	x0, x0, #0x4
               	ret
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x3
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>
               	add	x3, x0, #0x4
               	ldrsw	x4, [x0, #0x4]
               	add	x3, x3, x4
               	sub	x3, x3, x1
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x3, x0, #0x8
               	ldrsw	x4, [x0, #0x8]
               	add	x5, x0, #0x18
               	add	x3, x3, x4
               	sub	x3, x3, x5
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x10
               	ldr	x3, [x0]
               	add	x0, x0, x3
               	sub	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x0, #0x4
               	ldrsw	x4, [x0, #0x4]
               	add	x3, x3, x4
               	sub	x3, x3, x1
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x3, x0, #0x8
               	ldrsw	x4, [x0, #0x8]
               	add	x5, x0, #0x18
               	add	x3, x3, x4
               	sub	x3, x3, x5
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	add	x0, x0, #0x10
               	ldr	x3, [x0]
               	add	x0, x0, x3
               	sub	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udf	#0x0

<text_tbl>:
  4005b8: b8 fe ff ff  	.word	0xfffffeb8
  4005bc: 5c 0a 01 00  	.word	0x00010a5c
  4005c0: 10 00 00 00  	.word	0x00000010
  4005c4: 00 00 00 00  	.word	0x00000000
  4005c8: 50 0a 01 00  	.word	0x00010a50
  4005cc: 00 00 00 00  	.word	0x00000000

<text_end>:
  4005d0: 00 00 00 00  	.word	0x00000000
