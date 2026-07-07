
vla_scope_reclaim_loop.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	sub	x16, x29, #0x50
               	str	x16, [x16]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	sub	x17, x29, #0x50
               	ldr	x0, [x17]
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0x40               // =64
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	lsl	x0, x0, #2
               	stur	x0, [x29, #-0x28]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	sub	x16, x29, #0x50
               	ldr	x0, [x16]
               	sub	x0, x0, x17
               	sub	x17, x16, #0x2, lsl #12 // =0x2000
               	cmp	x0, x17
               	b.hs	<addr>
               	brk	#0x1
               	str	x0, [x16]
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x30]
               	b	<addr>
               	ldur	x1, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x30]
               	str	w0, [x1, x0, lsl #2]
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x30]
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x18]
               	cmp	x0, x1
               	b.lt	<addr>
               	ldur	x2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x0, x2, x0
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x38]
               	sub	x17, x29, #0x50
               	str	x0, [x17]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x40]
               	stur	w0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x40]
               	ldursw	x1, [x29, #-0x48]
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x48]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x48]
               	ldursw	x0, [x29, #-0x48]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x40]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x58
               	str	x0, [x17]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x58
               	ldr	x0, [x16]
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x58
               	str	x0, [x17]
               	b	<addr>
