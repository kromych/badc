
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
               	str	x0, [x7, #0x30]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x2, #0x8]
               	sub	x4, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x4]
               	sub	x5, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
               	mov	x1, #0x3e8              // =1000
               	mov	x7, #0x7d0              // =2000
               	sub	x3, x29, #0x18
               	mov	x6, #0x64               // =100
               	stur	w6, [x29, #-0x18]
               	mov	x6, #0x65               // =101
               	stur	w6, [x29, #-0x14]
               	mov	x6, #0x66               // =102
               	stur	w6, [x29, #-0x10]
               	mov	x6, #0x67               // =103
               	stur	w6, [x29, #-0xc]
               	mov	x6, #0x68               // =104
               	stur	w6, [x29, #-0x8]
               	mov	x6, #0x69               // =105
               	stur	w6, [x29, #-0x4]
               	str	x3, [sp]
               	mov	x16, #0xbb8             // =3000
               	str	x16, [sp, #0x8]
               	ldr	x0, [x0]
               	ldr	w3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	w4, [x4]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x17, #0x1a12            // =6674
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
