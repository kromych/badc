
addr_of_libm_import.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x20, <page>
               	ldr	x20, [x20, <lo12>]
               	adrp	x21, <page>
               	ldr	x21, [x21, <lo12>]
               	movi	d0, #0000000000000000
               	blr	x0
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	fmov	d0, d1
               	blr	x20
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	fmov	d0, #2.00000000
               	fmov	d1, #10.00000000
               	blr	x21
               	mov	x16, #0x4090000000000000 // =4652218415073722368
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	movi	d0, #0000000000000000
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<__c5_sys_sin>:
               	b	<addr>

<__c5_sys_cos>:
               	b	<addr>
