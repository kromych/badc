
sxtw_fold_source_liveness.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	lsl	x2, x0, #32
               	add	x0, x0, x1
               	asr	x2, x2, #32
               	add	x0, x2, x0
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x2                // =2
               	mov	x1, #0x7                // =7
               	lsl	x2, x0, #32
               	add	x0, x0, x1
               	asr	x2, x2, #32
               	add	x0, x2, x0
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
