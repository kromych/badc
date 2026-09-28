
static_initializer_address_casts.aarch64:	file format elf64-littleaarch64

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

<f>:
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x2, x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x4, x2, #0x4
               	cmp	x3, x4
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, #0x4
               	cmp	x3, x4
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x3, x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x3, #0x4
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, #0x8
               	cmp	x3, x4
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	add	x4, x2, #0x8
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	cmp	x4, x0
               	b.ne	<addr>
               	ldr	x4, [x3, #0x8]
               	cmp	x4, x1
               	b.ne	<addr>
               	ldr	x3, [x3, #0x10]
               	cmp	x3, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	cmp	x4, x0
               	b.ne	<addr>
               	ldr	x4, [x3, #0x8]
               	cmp	x4, x1
               	b.ne	<addr>
               	ldr	x1, [x3, #0x10]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
