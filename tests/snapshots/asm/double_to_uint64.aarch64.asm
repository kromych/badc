
double_to_uint64.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3d00             // =15616
               	movk	x0, #0x6091, lsl #16
               	movk	x0, #0x58e4, lsl #32
               	movk	x0, #0x43e1, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	mov	x0, #0x43e0000000000000 // =4890909195324358656
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x0, #0xa100             // =41216
               	movk	x0, #0x1438, lsl #16
               	movk	x0, #0x399b, lsl #32
               	movk	x0, #0x43ef, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x0
               	sub	x17, x29, #0x20
               	str	d16, [x17]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fcvtzu	x0, d1
               	mov	x17, #0x89e80000        // =2313682944
               	movk	x17, #0x2304, lsl #32
               	movk	x17, #0x8ac7, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcvtzu	x0, d1
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcvtzu	x0, d1
               	mov	x17, #0xc5080000        // =3305635840
               	movk	x17, #0xd8a1, lsl #32
               	movk	x17, #0xf9cc, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d1, [x16]
               	fcvtzu	x0, d1
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	x0, d0
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	fcvtzs	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x89e80000         // =2313682944
               	movk	x0, #0x2304, lsl #32
               	movk	x0, #0x8ac7, lsl #48
               	ucvtf	d0, x0
               	fcvtzu	x1, d0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
