
local_struct_array_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, #0xd2
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0xf2
               	sub	x1, x29, #0x30
               	str	x0, [x1]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x30
               	str	x0, [x1, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, #0xf4
               	sub	x1, x29, #0x30
               	str	x0, [x1, #0x10]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x30
               	str	x0, [x1, #0x18]
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x18]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
