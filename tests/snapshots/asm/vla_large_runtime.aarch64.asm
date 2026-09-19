
vla_large_runtime.aarch64:	file format elf64-littleaarch64

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
               	mov	x3, #0x1                // =1
               	stur	w3, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	lsl	x2, x0, #18
               	lsl	x0, x2, #2
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
               	cmp	x0, x2
               	b.ge	<addr>
               	str	w3, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	cmp	x0, x2
               	b.ge	<addr>
               	ldrsw	x4, [x1, x0, lsl #2]
               	add	x3, x3, x4
               	add	x0, x0, #0x1
               	cmp	x0, x2
               	b.lt	<addr>
               	cmp	x3, x2
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
