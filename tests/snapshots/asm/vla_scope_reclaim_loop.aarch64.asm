
vla_scope_reclaim_loop.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x0                // =0
               	mov	x5, #0x86a0             // =34464
               	movk	x5, #0x1, lsl #16
               	mov	x4, x3
               	cmp	w3, w5
               	b.ge	<addr>
               	mov	x6, sp
               	mov	x0, #0x100              // =256
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x40
               	b.ge	<addr>
               	str	w0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	and	x0, x3, #0x3f
               	ldrsw	x0, [x1, x0, lsl #2]
               	add	x4, x4, x0
               	mov	sp, x6
               	add	x3, x3, #0x1
               	cmp	w3, w5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x86a0             // =34464
               	movk	x2, #0x1, lsl #16
               	mov	x1, x0
               	cmp	w0, w2
               	b.ge	<addr>
               	and	x3, x0, #0x3f
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
