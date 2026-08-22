
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
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x22, x29, #0x38
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x22, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x22, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x22, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x22, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x22, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x21, w20
               	cmp	x21, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x24, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x25, #0x10              // =16
               	mov	x0, x24
               	mov	x2, x25
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x25
               	mov	x1, x24
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x22, x29, #0x10
               	mov	x24, #0x10              // =16
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x22, x29, #0x20
               	sub	x1, x29, #0x10
               	mov	x23, #0x10              // =16
               	mov	x0, x22
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0xa8]
               	ldr	x24, [x0, #0x88]
               	mov	x25, #0x8               // =8
               	mov	x9, x1
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x25
               	mov	x1, x22
               	blr	x9
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x21, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x22, #0x10              // =16
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x23, w20
               	mov	x9, x24
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x25
               	mov	x1, x21
               	blr	x9
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
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
