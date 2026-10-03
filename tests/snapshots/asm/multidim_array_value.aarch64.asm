
multidim_array_value.aarch64:	file format elf64-littleaarch64

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

<one>:
               	mov	x0, #0x1                // =1
               	ret

<zwei>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xc
               	ldrsw	x3, [x2, #0x8]
               	cmp	w3, #0x6
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x8]
               	cmp	w3, #0x6
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x2a               // =42
               	str	w4, [x3, #0x5c]
               	ldrsw	x4, [x3, #0x5c]
               	cmp	w4, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x0, #0xc]
               	cmp	w4, #0x4
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0xc]
               	cmp	w4, #0xa
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0x14]
               	cmp	w4, #0xc
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x2, #0x4]
               	cmp	w4, #0x5
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x4]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x0, #0x14]
               	cmp	w4, #0x6
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x14]
               	cmp	w4, #0x6
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x10]
               	cmp	w4, #0x5
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x2, x0
               	mov	x2, #0xaaab             // =43691
               	movk	x2, #0xaaaa, lsl #16
               	movk	x2, #0xaaaa, lsl #32
               	movk	x2, #0x2aaa, lsl #48
               	smulh	x4, x4, x2
               	asr	x4, x4, #1
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	cmp	x4, #0x1
               	b.ne	<addr>
               	add	x4, x0, #0x18
               	sub	x0, x4, x0
               	smulh	x0, x0, x2
               	asr	x0, x0, #1
               	lsr	x4, x0, #63
               	add	x0, x0, x4
               	cmp	x0, #0x2
               	b.ne	<addr>
               	add	x0, x3, #0x30
               	sub	x0, x0, x3
               	smulh	x0, x0, x2
               	asr	x0, x0, #3
               	lsr	x3, x0, #63
               	add	x0, x0, x3
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x1, #0xc
               	ldrsw	x3, [x0]
               	cmp	w3, #0xa
               	b.ne	<addr>
               	sub	x1, x0, x1
               	smulh	x1, x1, x2
               	asr	x1, x1, #1
               	lsr	x2, x1, #63
               	add	x1, x1, x2
               	cmp	x1, #0x1
               	b.ne	<addr>
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	blr	x0
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	blr	x0
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x14]
               	add	x0, x0, #0x2
               	ldursw	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
