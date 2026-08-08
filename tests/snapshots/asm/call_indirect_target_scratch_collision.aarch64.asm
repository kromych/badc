
call_indirect_target_scratch_collision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<sink_op>:
               	mov	x2, #0x0                // =0
               	ldrb	w0, [x1]
               	add	x0, x3, x0
               	str	w0, [x4]
               	mov	x0, x2
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x4, x29, #0x8
               	mov	x3, #0x0                // =0
               	ldr	x1, [x0]
               	mov	x5, #0xffff             // =65535
               	mov	x9, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x5
               	blr	x9
               	sxtw	x20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x2, [x29, #-0x8]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0x40              // =64
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
