
pointer_difference_qualified.aarch64:	file format elf64-littleaarch64

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

<pc_relative>:
               	ldr	x1, [x1]
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	sub	x0, x0, #0x1
               	ret

<unqualified_left>:
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	ret

<volatile_right>:
               	sub	x0, x0, x1
               	ret

<wide_elements>:
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #61
               	add	x0, x0, x1
               	asr	x0, x0, #3
               	ret

<back>:
               	lsl	x1, x1, #2
               	sub	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x48
               	add	x1, x0, #0x18
               	sub	x1, x1, x0
               	asr	x2, x1, #63
               	lsr	x2, x2, #62
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	sub	x1, x1, #0x1
               	sub	x2, x1, #0x5
               	add	x1, x0, #0xc
               	sub	x1, x1, x0
               	asr	x3, x1, #63
               	lsr	x3, x3, #62
               	add	x1, x1, x3
               	asr	x1, x1, #2
               	sub	x1, x1, #0x3
               	add	x2, x2, x1
               	sub	x1, x29, #0x8
               	add	x3, x1, #0x5
               	sub	x1, x3, x1
               	sub	x1, x1, #0x5
               	add	x2, x2, x1
               	sub	x1, x29, #0x28
               	add	x3, x1, #0x10
               	sub	x1, x3, x1
               	asr	x3, x1, #63
               	lsr	x3, x3, #61
               	add	x1, x1, x3
               	asr	x1, x1, #3
               	sub	x1, x1, #0x2
               	add	x1, x2, x1
               	add	x2, x0, #0x10
               	sub	x2, x2, #0x10
               	cmp	x2, x0
               	cset	x0, ne
               	add	x0, x1, x0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
