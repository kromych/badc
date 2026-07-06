
slot_coalesce_alloca.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xe0
               	sxtw	x0, w0
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	b	<addr>
               	sub	x3, x29, #0xc0
               	lsl	x4, x2, #3
               	add	x3, x3, x4
               	add	x4, x2, #0x1
               	sxtw	x4, w4
               	mul	x4, x4, x0
               	str	x4, [x3]
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x18
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc0
               	lsl	x3, x0, #3
               	add	x2, x2, x3
               	ldr	x2, [x2]
               	add	x6, x6, x2
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x18
               	b.lt	<addr>
               	mov	x0, x6
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	x16, x29, #0x90
               	str	x16, [x16]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	mul	x1, x0, x1
               	add	x0, x1, x0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x28]
               	mul	x1, x0, x1
               	add	x0, x1, x0
               	stur	x0, [x29, #-0x30]
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x40]
               	mul	x1, x0, x1
               	add	x0, x1, x0
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x58]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x58]
               	mul	x1, x0, x1
               	add	x0, x1, x0
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x30]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x48]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x60]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x40               // =64
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	sub	x16, x29, #0x90
               	ldr	x0, [x16]
               	sub	x0, x0, x17
               	sub	x17, x16, #0x2, lsl #12 // =0x2000
               	cmp	x0, x17
               	b.hs	<addr>
               	brk	#0x1
               	str	x0, [x16]
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x78]
               	b	<addr>
               	ldur	x0, [x29, #-0x70]
               	ldursw	x1, [x29, #-0x78]
               	ldur	x2, [x29, #-0x68]
               	add	x2, x2, x1
               	str	x2, [x0, x1, lsl #3]
               	ldursw	x0, [x29, #-0x78]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x78]
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x8
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x68]
               	bl	<addr>
               	stur	x0, [x29, #-0x80]
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x88]
               	b	<addr>
               	ldur	x0, [x29, #-0x70]
               	ldursw	x1, [x29, #-0x88]
               	ldr	x0, [x0, x1, lsl #3]
               	ldur	x2, [x29, #-0x68]
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x88]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x88]
               	ldursw	x0, [x29, #-0x88]
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
