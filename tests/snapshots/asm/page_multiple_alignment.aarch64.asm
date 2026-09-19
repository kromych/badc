
page_multiple_alignment.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x0, x3, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x0, x4, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	and	x0, x5, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	add	x6, x1, #0x4, lsl #12   // =0x4000
               	and	x0, x6, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x8, lsl #12   // =0x8000
               	and	x2, x2, #0x3fff
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	add	x2, x0, #0xc, lsl #12   // =0xc000
               	and	x2, x2, #0x3fff
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x2, x0, #0x10, lsl #12  // =0x10000
               	and	x2, x2, #0x3fff
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x2, x3, #0x1
               	and	x2, x2, #0x3fff
               	cbnz	x2, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	add	x2, x3, #0x2, lsl #12   // =0x2000
               	and	x2, x2, #0x3fff
               	cbnz	x2, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x2, #0xb                // =11
               	str	w2, [x4]
               	mov	x2, #0x16               // =22
               	str	w2, [x5]
               	mov	x2, #0x21               // =33
               	str	w2, [x6]
               	add	x2, x0, #0x14, lsl #12  // =0x14000
               	mov	x3, #0x2c               // =44
               	str	w3, [x2]
               	ldrsw	x3, [x4]
               	cmp	w3, #0xb
               	b.ne	<addr>
               	ldrsw	x3, [x5]
               	cmp	w3, #0x16
               	b.ne	<addr>
               	ldrsw	x1, [x6]
               	cmp	w1, #0x21
               	b.ne	<addr>
               	ldrsw	x0, [x2]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
