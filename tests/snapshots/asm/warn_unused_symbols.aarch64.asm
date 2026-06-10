
warn_unused_symbols.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	sxtw	x1, w1
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x5                // =5
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
