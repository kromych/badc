
prototype_param_keeps_object_shape.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	sub	x0, x1, x0
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x30
               	sub	x1, x1, x0
               	asr	x2, x1, #63
               	lsr	x2, x2, #62
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	cmp	x1, #0xc
               	b.ne	<addr>
               	add	x1, x0, #0x10
               	sub	x0, x1, x0
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x6
               	sub	x0, x1, x0
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
