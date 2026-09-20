
function_typed_parameter.aarch64:	file format elf64-littleaarch64

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

<apply>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldp	x29, x30, [sp], #0x10
               	ret

<apply_bare>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldp	x29, x30, [sp], #0x10
               	ret

<passthrough>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldp	x29, x30, [sp], #0x10
               	ret

<doubler>:
               	lsl	x0, x0, #1
               	ret

<take_slot>:
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x0, x0, #2
               	add	x0, x1, x0
               	ret

<plain_func>:
               	add	x0, x0, #0x1
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xc
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
