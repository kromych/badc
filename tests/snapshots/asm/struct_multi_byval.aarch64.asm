
struct_multi_byval.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldr	x1, [x29, #0x10]
               	adrp	x7, <page>
               	add	x0, x0, x0, lsr #32
               	add	x0, x0, #0x3e8
               	add	x0, x0, x2
               	add	x0, x0, x2, lsr #32
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x5, lsr #32
               	add	x0, x0, x6
               	add	x0, x0, x6, lsr #32
               	add	x0, x0, #0x7d0
               	ldrsw	x2, [x1]
               	add	x0, x0, x2
               	ldrsw	x2, [x1, #0x4]
               	add	x0, x0, x2
               	ldrsw	x2, [x1, #0x8]
               	add	x0, x0, x2
               	ldrsw	x2, [x1, #0xc]
               	add	x0, x0, x2
               	ldrsw	x2, [x1, #0x10]
               	add	x0, x0, x2
               	ldrsw	x1, [x1, #0x14]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	str	x0, [x7, #0x20]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x4, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x4]
               	mov	x1, #0x64               // =100
               	movk	x1, #0x65, lsl #32
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x66               // =102
               	movk	x1, #0x67, lsl #32
               	stur	x1, [x29, #-0x10]
               	mov	x1, #0x68               // =104
               	movk	x1, #0x69, lsl #32
               	stur	x1, [x29, #-0x8]
               	mov	x2, #0x3                // =3
               	movk	x2, #0x4, lsl #32
               	mov	x3, #0x5                // =5
               	mov	x5, #0x1                // =1
               	movk	x5, #0x2, lsl #32
               	sub	x16, x29, #0x18
               	str	x16, [sp]
               	mov	x16, #0xbb8             // =3000
               	str	x16, [sp, #0x8]
               	mov	x6, x2
               	mov	x1, #0x3e8              // =1000
               	mov	x7, #0x7d0              // =2000
               	ldr	x0, [x0]
               	ldr	w4, [x4]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #0x1a12            // =6674
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
