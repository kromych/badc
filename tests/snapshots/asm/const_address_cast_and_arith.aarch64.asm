
const_address_cast_and_arith.aarch64:	file format elf64-littleaarch64

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
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x0, #0x8]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x0, #0x10]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0, #0x18]
               	ldrsw	x2, [x2]
               	cmp	w2, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x2, [x0, #0x20]
               	ldrsw	x2, [x2]
               	cmp	w2, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x2, [x0, #0x28]
               	add	x3, x1, #0x4
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x2, [x0, #0x30]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldr	x0, [x0, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x20
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x40
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x0, x2
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x0, x2
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x0, x2
               	cmp	x0, #0x30
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x0, x2
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x0, x0, x2
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x0, x0, x2
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x0, x0, x2
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x18
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x0                // =0
               	ret
