
struct_arg_value_form_inline.aarch64:	file format elf64-littleaarch64

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

<take_kuid>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_triple>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrb	w2, [x0]
               	ldrb	w1, [x0, #0x1]
               	lsl	x1, x1, #8
               	orr	x1, x2, x1
               	ldrb	w0, [x0, #0x2]
               	lsl	x0, x0, #16
               	orr	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0, #0x4]
               	lsl	x1, x1, #32
               	ldr	w0, [x0]
               	orr	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_wide>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	ret
