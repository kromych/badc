
nonconst_local_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	str	x19, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x2, #0x2a               // =42
               	mov	x1, #0x63               // =99
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	w2, [x0]
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2a               // =42
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	mov	x3, #0x63               // =99
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	str	w2, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2a               // =42
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	mov	x3, #0x63               // =99
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	sub	x0, x29, #0x30
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	str	w2, [x0]
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2a               // =42
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	mov	x3, #0x63               // =99
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x50
               	ldrsw	x2, [x0]
               	mov	x3, #0x63               // =99
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
