
multidim_array_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x14]
               	cmp	x1, #0x1
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x20]
               	cmp	x2, #0x6
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x24]
               	cmp	x2, #0x7
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x2, [x0, #0x28]
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x2, [x0, #0x3c]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x40]
               	cmp	x2, #0x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x2, [x0, #0x60]
               	cmp	x2, #0x7
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x50]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x24]
               	ldrsw	x3, [x0, #0x24]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x60]
               	ldrsw	x0, [x0, #0x60]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x20]
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
