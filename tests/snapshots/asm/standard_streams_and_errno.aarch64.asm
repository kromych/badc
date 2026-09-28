
standard_streams_and_errno.aarch64:	file format elf64-littleaarch64

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

<__c5_lazy_stream>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, w20, sxtw #3]
               	cbz	x1, <addr>
               	ldr	x0, [x0, w20, sxtw #3]
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1, #0x10]
               	ldr	x1, [x1, w20, sxtw #3]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, w20, sxtw #3]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, w20, sxtw #3]
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x20, x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x21               // =33
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x21
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x78               // =120
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	str	wzr, [x0]
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	mov	x1, #0x22               // =34
               	str	w1, [x0]
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
