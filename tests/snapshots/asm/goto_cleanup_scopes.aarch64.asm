
goto_cleanup_scopes.aarch64:	file format elf64-littleaarch64

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

<exits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, x3
               	stur	w3, [x29, #-0x8]
               	stur	w3, [x29, #-0x8]
               	stur	w3, [x29, #-0x8]
               	stur	w3, [x29, #-0x8]
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	cmp	w0, #0x2
               	b.ne	<addr>
               	cbnz	w4, <addr>
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x64               // =100
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x63               // =99
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x62               // =98
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x61               // =97
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	b	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x64               // =100
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x63               // =99
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x2e               // =46
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x62               // =98
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	w3, [x2, x5]
               	ldrsw	x5, [x1]
               	add	x6, x5, #0x1
               	str	w6, [x1]
               	mov	x6, #0x61               // =97
               	strb	w6, [x2, x5]
               	ldrsw	x5, [x1]
               	strb	wzr, [x2, x5]
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x7c               // =124
               	strb	w3, [x1, x2]
               	ldrsw	x2, [x0]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x64               // =100
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x63               // =99
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x64               // =100
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x63               // =99
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x1, x3]
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
               	mov	x3, #0x64               // =100
               	strb	w3, [x1, x2]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x63               // =99
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x1, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x1, x3]
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

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x8]
               	cbz	x0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x63               // =99
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x7c               // =124
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x64               // =100
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x63               // =99
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	b	<addr>

<from_case>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	cmp	w0, #0x1
               	b.lt	<addr>
               	stur	wzr, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x2d               // =45
               	strb	w4, [x1, x3]
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
               	mov	x3, #0x7c               // =124
               	strb	w3, [x1, x2]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	b	<addr>

<computed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adr	x3, <addr>
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	mov	x5, #0x62               // =98
               	strb	w5, [x1, x4]
               	ldrsw	x4, [x0]
               	strb	wzr, [x1, x4]
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	mov	x5, #0x61               // =97
               	strb	w5, [x1, x4]
               	ldrsw	x4, [x0]
               	strb	wzr, [x1, x4]
               	br	x3
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x7c               // =124
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x21               // =33
               	strb	w4, [x1, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x1, x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adr	x3, <addr>
               	b	<addr>

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x8]
               	sub	x5, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x5]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x5, #0x8]
               	mov	x1, x3
               	br	x2
               	ldrsw	x2, [x0]
               	add	x7, x2, #0x1
               	str	w7, [x0]
               	mov	x7, #0x78               // =120
               	strb	w7, [x4, x2]
               	ldrsw	x2, [x0]
               	strb	w3, [x4, x2]
               	add	x1, x1, #0x1
               	ldrb	w2, [x6, x1]
               	ldr	x2, [x5, x2, lsl #3]
               	br	x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x3, #0x7c               // =124
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
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mutex_lock>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	bl	<addr>
               	brk	#0x1
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	ldrsw	x1, [x0, #0x4]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x4]
               	ldp	x29, x30, [sp], #0x10
               	ret

<mutex_unlock>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	bl	<addr>
               	brk	#0x1
               	str	wzr, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret

<__free_kfree>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret

<guarded>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	ldr	x1, [x0]
               	cbnz	w20, <addr>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	cmp	w20, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	cbz	x0, <addr>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	cmp	w20, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	cbz	x0, <addr>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	cbz	x0, <addr>
               	bl	<addr>
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	stur	x0, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	str	xzr, [x1]
               	bl	<addr>
               	cmp	w20, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x1]
               	stur	x1, [x29, #-0x8]
               	str	w2, [x1]
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	ldrsw	x3, [x1]
               	cbnz	w3, <addr>
               	ldrsw	x3, [x0]
               	cmp	w3, #0x1
               	cset	x5, eq
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x6, [x3]
               	add	x6, x6, #0x1
               	str	w6, [x3]
               	cbnz	w5, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x5]
               	cbnz	w6, <addr>
               	ldrsw	x6, [x3]
               	str	w6, [x5]
               	str	w2, [x0]
               	str	w4, [x1]
               	str	w2, [x1]
               	ldrsw	x5, [x0]
               	add	x5, x5, #0x1
               	str	w5, [x0]
               	str	w4, [x1]
               	str	w2, [x1]
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	ldrsw	x1, [x1]
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	cset	x1, eq
               	ldrsw	x2, [x3]
               	add	x2, x2, #0x1
               	str	w2, [x3]
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x2, [x3]
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	mov	x2, x0
               	mov	x4, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x1                // =1
               	str	w5, [x3]
               	stur	x3, [x29, #-0x8]
               	add	x4, x4, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	str	w0, [x3]
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	b	<addr>
               	str	w0, [x3]
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w4, #0x3
               	cset	x1, ne
               	add	x0, x0, x1
               	mov	x1, #0x0                // =0
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	cset	x1, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x2, [x0]
               	str	w2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x2]
               	stur	x2, [x29, #-0x8]
               	ldrsw	x4, [x2]
               	stur	w4, [x29, #-0x10]
               	str	w1, [x2]
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
               	ldursw	x4, [x29, #-0x10]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x3]
               	cmp	w2, #0x1
               	cset	x2, eq
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	cbnz	w2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x2]
               	mov	x0, x1
               	bl	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrb	w1, [x1, x0]
               	ldrb	w3, [x2, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
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
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x1
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
               	mov	x0, #0x4                // =4
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
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	strb	w0, [x20]
               	bl	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x20, x0]
               	cbz	x1, <addr>
               	ldrb	w1, [x20, x0]
               	ldrb	w3, [x2, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w1, [x20, x0]
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1, x0]
               	ldrb	w0, [x2, x0]
               	cmp	w3, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	strb	w0, [x1]
               	mov	x3, #0x78               // =120
               	stur	w3, [x29, #-0x10]
               	mov	x3, #0x79               // =121
               	stur	w3, [x29, #-0x8]
               	and	x4, x3, #0xff
               	ldrsw	x3, [x2]
               	add	x5, x3, #0x1
               	str	w5, [x2]
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x2]
               	strb	w0, [x1, x3]
               	ldrsw	x3, [x2]
               	add	x4, x3, #0x1
               	str	w4, [x2]
               	mov	x4, #0x7c               // =124
               	strb	w4, [x1, x3]
               	ldrsw	x3, [x2]
               	strb	w0, [x1, x3]
               	ldursw	x3, [x29, #-0x10]
               	and	x4, x3, #0xff
               	ldrsw	x3, [x2]
               	add	x5, x3, #0x1
               	str	w5, [x2]
               	strb	w4, [x1, x3]
               	ldrsw	x2, [x2]
               	strb	w0, [x1, x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1, x0]
               	ldrb	w0, [x2, x0]
               	cmp	w3, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	strb	w0, [x1]
               	ldrsw	x4, [x2]
               	add	x3, x4, #0x1
               	str	w3, [x2]
               	mov	x3, #0x61               // =97
               	strb	w3, [x1, x4]
               	ldrsw	x4, [x2]
               	strb	w0, [x1, x4]
               	ldrsw	x4, [x2]
               	add	x5, x4, #0x1
               	str	w5, [x2]
               	strb	w3, [x1, x4]
               	ldrsw	x4, [x2]
               	strb	w0, [x1, x4]
               	ldrsw	x4, [x2]
               	add	x5, x4, #0x1
               	str	w5, [x2]
               	strb	w3, [x1, x4]
               	ldrsw	x3, [x2]
               	strb	w0, [x1, x3]
               	ldrsw	x3, [x2]
               	add	x4, x3, #0x1
               	str	w4, [x2]
               	mov	x4, #0x7c               // =124
               	strb	w4, [x1, x3]
               	ldrsw	x2, [x2]
               	strb	w0, [x1, x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	strb	w0, [x20]
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
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	strb	w0, [x20]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	str	w20, [x0]
               	strb	w20, [x2]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x21, #0x0               // =0
               	str	w21, [x22]
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, x20, lsl #2]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldrsw	x0, [x22]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, x20, lsl #2]
               	cmp	w0, w1
               	cset	x21, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	cbnz	w21, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	add	x20, x20, #0x1
               	cmp	w20, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x9
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
