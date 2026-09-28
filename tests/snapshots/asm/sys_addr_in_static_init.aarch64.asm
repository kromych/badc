
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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	blr	x2
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	ldr	x2, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x9, x2
               	mov	x2, x1
               	blr	x9
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x68]
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	cmp	w21, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret

<__c5_sys_open>:
               	b	<addr>

<__c5_sys_read>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x20]
               	ldur	x2, [x29, #-0x10]
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_close>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_access>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x10]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
