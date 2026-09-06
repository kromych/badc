
struct_multi_byval.aarch64:	file format elf64-littleaarch64

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

<take_many>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x18
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x4, [x16]
               	sub	x16, x29, #0x30
               	str	x5, [x16]
               	str	x6, [x16, #0x8]
               	sub	x0, x29, #0x48
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	ldrsw	x1, [x1, #0x4]
               	add	x1, x2, x1
               	add	x2, x1, #0x3e8
               	sub	x1, x29, #0x18
               	ldrsw	x4, [x1]
               	add	x2, x2, x4
               	ldrsw	x4, [x1, #0x4]
               	add	x2, x2, x4
               	ldrsw	x1, [x1, #0x8]
               	add	x1, x2, x1
               	sub	x2, x29, #0x20
               	ldrsw	x2, [x2]
               	add	x2, x1, x2
               	sub	x1, x29, #0x30
               	ldrsw	x4, [x1]
               	add	x2, x2, x4
               	ldrsw	x4, [x1, #0x4]
               	add	x2, x2, x4
               	ldrsw	x4, [x1, #0x8]
               	add	x2, x2, x4
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	add	x1, x1, #0x7d0
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x14]
               	add	x0, x1, x0
               	ldursw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	str	x0, [x3]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xb8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x2, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x2, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x2, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x2, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x2, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x3]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x3, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x3, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x3, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x4, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x4
               	sub	x6, x29, #0x88
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x6]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x6, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x6
               	mov	x1, #0x3e8              // =1000
               	mov	x5, #0x7d0              // =2000
               	mov	x7, #0xbb8              // =3000
               	sub	sp, sp, #0x10
               	str	x6, [sp]
               	str	x7, [sp, #0x8]
               	mov	x7, x5
               	mov	x5, x4
               	mov	x4, x3
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x4, [x4]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x1a12            // =6674
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
