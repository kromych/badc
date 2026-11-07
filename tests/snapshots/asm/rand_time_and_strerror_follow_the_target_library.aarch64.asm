
rand_time_and_strerror_follow_the_target_library.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x22, w20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x22, x0
               	cset	x22, eq
               	sxtw	x23, w21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	cset	x2, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x4, x21
               	mov	x3, x20
               	bl	<addr>
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	stur	xzr, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0x5f5e, lsl #16
               	cmp	x0, x17
               	cset	x20, gt
               	ldur	x1, [x29, #-0x8]
               	cmp	x0, x1
               	cset	x21, eq
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x22, ge
               	mov	x0, #0xa                // =10
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x22               // =34
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	bl	<addr>
               	mov	x1, #0xd                // =13
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
