
function_address_arithmetic_counts_bytes.aarch64:	file format elf64-littleaarch64

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

<g>:
               	mov	x0, #0x1                // =1
               	ret

<after>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, x0
               	cmp	x2, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, x0
               	mov	x17, #-0x2              // =-2
               	cmp	x2, x17
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, x0
               	cmp	x2, #0x3
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, x0
               	cmp	x2, #0x1
               	b.ne	<addr>
               	sub	x1, x1, x0
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x1, x2
               	mov	x17, #-0x2              // =-2
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, x0
               	cmp	x1, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, x0
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, x0
               	mov	x17, #-0x4              // =-4
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x0, x1, x0
               	cmp	x0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
