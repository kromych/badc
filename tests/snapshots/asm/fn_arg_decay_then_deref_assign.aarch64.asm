
fn_arg_decay_then_deref_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<take_action>:
               	mov	x0, #0x0                // =0
               	ret

<run>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x1, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x29               // =41
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
