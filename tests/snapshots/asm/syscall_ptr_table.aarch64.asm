
syscall_ptr_table.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x570              // =1392
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x120]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x20]
               	ldr	x24, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x42               // =66
               	mov	x3, #0x1a4              // =420
               	mov	x9, x1
               	mov	x1, x2
               	mov	x2, x3
               	blr	x9
               	sxtw	x20, w0
               	cmp	x20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x1, #0x400              // =1024
               	mov	x9, x24
               	mov	x0, x20
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	sub	x1, x29, #0xb8
               	mov	x9, x23
               	mov	x0, x20
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x22
               	mov	x0, x20
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x9, x21
               	mov	x0, x20
               	blr	x9
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret

<__c5_sys_open>:
               	b	<addr>

<__c5_sys_close>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x10
               	ret

<__c5_sys_ftruncate>:
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x20
               	ret

<__c5_sys_fcntl>:
               	b	<addr>

<__c5_sys_stat>:
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x20
               	ret

<__c5_sys_fstat>:
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #0x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	add	sp, sp, #0x20
               	ret
