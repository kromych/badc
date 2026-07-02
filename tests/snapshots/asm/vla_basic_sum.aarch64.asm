
vla_basic_sum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x30
               	str	x16, [x16]
               	stur	w0, [x29, #0x10]
               	ldursw	x0, [x29, #0x10]
               	lsl	x0, x0, #2
               	stur	x0, [x29, #-0x10]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	sub	x16, x29, #0x30
               	ldr	x0, [x16]
               	sub	x0, x0, x17
               	sub	x17, x16, #0x2, lsl #12 // =0x2000
               	cmp	x0, x17
               	b.hs	<addr>
               	brk	#0x1
               	str	x0, [x16]
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x18]
               	lsl	x2, x1, #1
               	str	w2, [x0, x1, lsl #2]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x28]
               	ldursw	x0, [x29, #-0x28]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x28]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x28]
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x28]
               	ldrsw	x1, [x1, x2, lsl #2]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
