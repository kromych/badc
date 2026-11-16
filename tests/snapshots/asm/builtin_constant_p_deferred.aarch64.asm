
builtin_constant_p_deferred.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x0, #0x15               // =21
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, x0
               	mov	x2, #0x400              // =1024
               	cmp	w0, #0x2a
               	csel	x0, x2, x1, ne
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
