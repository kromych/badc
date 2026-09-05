
sys_addr_in_static_init.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x1, #0x0                // =0
               	ldr	x0, [x20, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x0
               	mov	x0, x2
               	mov	x2, x1
               	blr	x9
               	sxtw	x21, w0
               	cmp	w21, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x0, [x20, #0x68]
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	mov	x22, x0
               	ldr	x0, [x20, #0x20]
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	cmp	w22, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<__c5_sys_open>:
               	b	<addr>

<__c5_sys_read>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x20]
               	ldur	x2, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret

<__c5_sys_close>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret

<__c5_sys_access>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x10]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
