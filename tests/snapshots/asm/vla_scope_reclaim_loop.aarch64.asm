
vla_scope_reclaim_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x4, #0x0                // =0
               	mov	x6, x4
               	b	<addr>
               	mov	x7, sp
               	mov	x0, #0x100              // =256
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	mov	sp, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w0, [x2, x1, lsl #2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x17, #0x3f              // =63
               	and	x0, x5, x17
               	ldrsw	x0, [x2, x0, lsl #2]
               	add	x6, x6, x0
               	mov	sp, x7
               	add	x4, x5, #0x1
               	sxtw	x5, w4
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x5, x17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	add	x2, x2, x3
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x1, x17
               	b.lt	<addr>
               	cmp	x6, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	sub	sp, x29, #0x70
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
