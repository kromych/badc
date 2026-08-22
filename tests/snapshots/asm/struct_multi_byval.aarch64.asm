
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
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
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
               	ldur	x1, [x29, #0x70]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	add	x0, x0, #0x3e8
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0xc]
               	add	x0, x0, x1
               	add	x0, x0, #0x7d0
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0xc]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x14]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x80]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	str	x0, [x2]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x80
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	mov	x1, #0x3e8              // =1000
               	sub	x2, x29, #0x50
               	sub	x3, x29, #0x58
               	sub	x4, x29, #0x68
               	mov	x5, #0x7d0              // =2000
               	sub	x6, x29, #0x80
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
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
