
generic_selection_qualified.aarch64:	file format elf64-littleaarch64

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

<pick>:
               	mov	x0, #0x2                // =2
               	ret

<pickc>:
               	mov	x0, #0x1                // =1
               	ret

<pickw>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	sub	x2, x0, x0
               	asr	x5, x2, #63
               	lsr	x5, x5, #62
               	add	x2, x2, x5
               	asr	x2, x2, #2
               	cbnz	x2, <addr>
               	add	x2, x0, #0x4
               	sub	x0, x2, x0
               	asr	x2, x0, #63
               	lsr	x2, x2, #62
               	add	x0, x0, x2
               	asr	x0, x0, #2
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	stur	x0, [x29, #-0x20]
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
