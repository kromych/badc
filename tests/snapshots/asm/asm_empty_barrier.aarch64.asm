
asm_empty_barrier.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	ret

<barrier_memory>:
               	mov	x0, #0x0                // =0
               	ret

<barrier_bare>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x29               // =41
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldursw	x0, [x29, #-0x8]
               	str	w0, [x1]
               	sxtw	x0, w0
               	sub	x0, x0, #0x2a
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
