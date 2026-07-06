
sys_addr_in_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x430              // =1072
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
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
               	cmp	x21, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20, #0x68]
               	sub	x1, x29, #0x48
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	sxtw	x22, w0
               	ldr	x0, [x20, #0x20]
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	cmp	x22, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_open>:
               	b	<addr>

<__c5_sys_read>:
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	ldur	x2, [x29, #0x30]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<__c5_sys_close>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	ldur	x0, [x29, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<__c5_sys_access>:
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
