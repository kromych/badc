
builtin_constant_p_deferred.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x15               // =21
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	mov	x1, #0x12               // =18
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, x1
               	sxtw	x1, w1
               	sxtw	x1, w1
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x400              // =1024
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
