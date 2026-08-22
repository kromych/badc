
libc_pread64_pwrite64.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x80]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x21, #0x10              // =16
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w20
               	sub	x1, x29, #0x10
               	mov	x3, #0x0                // =0
               	mov	x2, x21
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x20
               	mov	x21, #0x0               // =0
               	mov	x22, #0x10              // =16
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w20
               	sub	x1, x29, #0x20
               	mov	x2, x22
               	mov	x3, x21
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0xa8]
               	ldr	x21, [x0, #0x88]
               	sxtw	x0, w20
               	sub	x2, x29, #0x10
               	mov	x3, #0x8                // =8
               	mov	x4, #0x10               // =16
               	mov	x9, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	blr	x9
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	mov	x22, #0x10              // =16
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w20
               	sub	x1, x29, #0x20
               	mov	x2, #0x8                // =8
               	mov	x9, x21
               	mov	x3, x22
               	blr	x9
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret

<__c5_sys_pread64>:
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	ldur	x2, [x29, #0x30]
               	ldur	x3, [x29, #0x40]
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x40
               	ret

<__c5_sys_pwrite64>:
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	ldur	x2, [x29, #0x30]
               	ldur	x3, [x29, #0x40]
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x40
               	ret
