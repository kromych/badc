
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x2, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x0, x3, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x4, x0, #0x3fff
               	cbz	x4, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	add	x4, x0, #0x4, lsl #12   // =0x4000
               	and	x0, x4, #0x3fff
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x5, x0, #0x8, lsl #12   // =0x8000
               	and	x5, x5, #0x3fff
               	cbz	x5, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	add	x5, x0, #0xc, lsl #12   // =0xc000
               	and	x5, x5, #0x3fff
               	cbz	x5, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x5, x0, #0x10, lsl #12  // =0x10000
               	and	x5, x5, #0x3fff
               	cbz	x5, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x5, x1, #0x1
               	and	x5, x5, #0x3fff
               	cbnz	w5, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	add	x1, x1, #0x2, lsl #12   // =0x2000
               	and	x1, x1, #0x3fff
               	cbnz	w1, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x1, #0xb                // =11
               	str	w1, [x2]
               	mov	x1, #0x16               // =22
               	str	w1, [x3]
               	mov	x1, #0x21               // =33
               	str	w1, [x4]
               	add	x0, x0, #0x14, lsl #12  // =0x14000
               	mov	x1, #0x2c               // =44
               	str	w1, [x0]
               	ldrsw	x1, [x2]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	ldrsw	x1, [x3]
               	cmp	w1, #0x16
               	b.ne	<addr>
               	ldrsw	x1, [x4]
               	cmp	w1, #0x21
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
