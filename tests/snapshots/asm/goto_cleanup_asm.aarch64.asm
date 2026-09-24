
goto_cleanup_asm.aarch64:	file format elf64-littleaarch64

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

<by_asm>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x2d               // =45
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x2e               // =46
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x7c               // =124
               	strb	w3, [x1, x2]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x62               // =98
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x62               // =98
               	strb	w3, [x1, x2]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w1, [x20, x0]
               	ldrb	w0, [x2, x0]
               	cmp	w1, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w3, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cbnz	w3, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x2]
               	mov	x1, #0x1                // =1
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x1f               // =31
               	cmp	w1, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	mov	x1, #0x0                // =0
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x1e               // =30
               	cmp	w1, #0x1e
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
