
strtoul_64bit_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x330              // =816
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x17, #0xf200            // =61952
               	movk	x17, #0x2a05, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0x1a00            // =6656
               	movk	x17, #0x1871, lsl #16
               	movk	x17, #0x2, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
