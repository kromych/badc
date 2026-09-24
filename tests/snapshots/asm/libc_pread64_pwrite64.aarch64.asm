
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
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x1, x29, #0x20
               	mov	x2, #0x10               // =16
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x10               // =16
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x10
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0, #0xa8]
               	ldr	x21, [x0, #0x88]
               	sxtw	x0, w20
               	sub	x1, x29, #0x20
               	mov	x2, #0x8                // =8
               	mov	x3, #0x10               // =16
               	blr	x4
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w20
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	mov	x3, #0x10               // =16
               	blr	x21
               	cmp	x0, #0x8
               	b.eq	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret

<__c5_sys_pread64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x30]
               	stur	x2, [x29, #-0x20]
               	stur	x3, [x29, #-0x10]
               	ldur	x0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x10]
               	bl	<addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_pwrite64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x30]
               	stur	x2, [x29, #-0x20]
               	stur	x3, [x29, #-0x10]
               	ldur	x0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x10]
               	bl	<addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
