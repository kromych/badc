
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
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x21, <page>
               	ldr	x21, [x21, <lo12>]
               	adrp	x22, <page>
               	ldr	x22, [x22, <lo12>]
               	mov	x20, #0x0               // =0
               	mov	x9, x0
               	fmov	d0, x20
               	blr	x9
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x9, x21
               	fmov	d0, x20
               	blr	x9
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	mov	x9, x22
               	fmov	d0, x0
               	fmov	d1, x1
               	blr	x9
               	mov	x0, #0x4090000000000000 // =4652218415073722368
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x22, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x22, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldr	x0, [x22, #0x8]
               	mov	x20, #0x0               // =0
               	mov	x9, x0
               	fmov	d0, x20
               	blr	x9
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<__c5_sys_sin>:
               	b	<addr>

<__c5_sys_cos>:
               	b	<addr>
