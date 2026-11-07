
tokenizers_keep_state_in_the_caller.aarch64:	file format elf64-littleaarch64

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

<wide>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, x0
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x16, [x1, #0x20]
               	str	x16, [x0, #0x20]
               	sub	x1, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x1, #0x10]
               	ldr	w16, [x2, #0x18]
               	str	w16, [x1, #0x18]
               	stur	xzr, [x29, #-0x70]
               	stur	xzr, [x29, #-0x68]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x70
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x70]
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x68]
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x70
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x70
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	blr	x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x70
               	blr	x20
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	blr	x20
               	cbz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	stur	xzr, [x29, #-0x60]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x60
               	blr	x20
               	cbz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret

<call_wcstok>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<call_strtok_r>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldrh	w16, [x1, #0x8]
               	strh	w16, [x0, #0x8]
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldrh	w16, [x2, #0x4]
               	strh	w16, [x1, #0x4]
               	ldrb	w16, [x2, #0x6]
               	strb	w16, [x1, #0x6]
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x20]
               	cbnz	x0, <addr>
               	mov	x0, #0x30               // =48
               	cbz	x0, <addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x18
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	cbnz	x0, <addr>
               	mov	x0, #0x31               // =49
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x32               // =50
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x18
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x33               // =51
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x34               // =52
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x18
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x35               // =53
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x36               // =54
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x18
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x37               // =55
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
