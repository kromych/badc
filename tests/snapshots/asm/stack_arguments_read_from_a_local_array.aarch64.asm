
stack_arguments_read_from_a_local_array.aarch64:	file format elf64-littleaarch64

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

<sum_weighted>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x1, x0
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.ge	<addr>
               	add	x0, x0, #0x1
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	x3, [x3]
               	madd	x1, x0, x3, x1
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	mov	x1, #0x14               // =20
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	csel	x1, x1, x2, gt
               	mov	x0, #0x0                // =0
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x2, x29, #0xa0
               	add	x3, x0, x0, lsl #1
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	ldur	x8, [x29, #-0xa0]
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0xa0]
               	mov	x0, #0x15               // =21
               	ldur	x1, [x29, #-0x98]
               	ldur	x2, [x29, #-0x90]
               	ldur	x3, [x29, #-0x88]
               	ldur	x4, [x29, #-0x80]
               	ldur	x5, [x29, #-0x78]
               	ldur	x6, [x29, #-0x70]
               	ldur	x7, [x29, #-0x68]
               	ldur	x16, [x29, #-0x60]
               	str	x16, [sp]
               	ldur	x16, [x29, #-0x58]
               	str	x16, [sp, #0x8]
               	ldur	x16, [x29, #-0x50]
               	str	x16, [sp, #0x10]
               	ldur	x16, [x29, #-0x48]
               	str	x16, [sp, #0x18]
               	ldur	x16, [x29, #-0x40]
               	str	x16, [sp, #0x20]
               	ldur	x16, [x29, #-0x38]
               	str	x16, [sp, #0x28]
               	ldur	x16, [x29, #-0x30]
               	str	x16, [sp, #0x30]
               	ldur	x16, [x29, #-0x28]
               	str	x16, [sp, #0x38]
               	ldur	x16, [x29, #-0x20]
               	str	x16, [sp, #0x40]
               	ldur	x16, [x29, #-0x18]
               	str	x16, [sp, #0x48]
               	ldur	x16, [x29, #-0x10]
               	str	x16, [sp, #0x50]
               	ldur	x16, [x29, #-0x8]
               	str	x16, [sp, #0x58]
               	str	x8, [sp, #0x60]
               	ldur	x16, [x29, #-0xa0]
               	str	x16, [sp, #0x68]
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	add	x3, x1, x1, lsl #1
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	madd	x2, x1, x3, x2
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	mov	x17, #0x521c            // =21020
               	add	x1, x2, x17
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1                // =1
               	cmp	x0, x1
               	csel	x0, x2, x3, eq
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
