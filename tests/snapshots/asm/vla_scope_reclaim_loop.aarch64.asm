
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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x4, #0x0                // =0
               	mov	x6, #0x3f               // =63
               	mov	x7, #0x86a0             // =34464
               	movk	x7, #0x1, lsl #16
               	mov	x5, x4
               	b	<addr>
               	mov	x8, sp
               	mov	x0, #0x100              // =256
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	str	w0, [x2, x1, lsl #2]
               	add	x0, x1, #0x1
               	cmp	x0, #0x40
               	b.lt	<addr>
               	sxtw	x0, w4
               	and	x1, x0, x6
               	ldrsw	x1, [x2, x1, lsl #2]
               	add	x5, x5, x1
               	mov	sp, x8
               	add	x4, x0, #0x1
               	cmp	x4, x7
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3f               // =63
               	mov	x4, #0x86a0             // =34464
               	movk	x4, #0x1, lsl #16
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	and	x6, x2, x3
               	add	x1, x1, x6
               	add	x0, x2, #0x1
               	cmp	x0, x4
               	b.lt	<addr>
               	cmp	x5, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
