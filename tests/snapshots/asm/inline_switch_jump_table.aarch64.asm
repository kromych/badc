
inline_switch_jump_table.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<use>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	x1, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	mov	x1, #0x2                // =2
               	mov	x3, #0xc8               // =200
               	cmp	x0, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x2, #0x65               // =101
               	sub	x4, x3, x0
               	add	x3, x0, #0x1
               	sxtw	x5, w3
               	cmp	x5, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x5, lsl #3]
               	br	x17
               	add	x3, x2, #0x1
               	sub	x5, x4, x5
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	add	x1, x1, x4
               	mov	x17, #0xa               // =10
               	mul	x2, x3, x17
               	add	x1, x1, x2
               	add	x1, x1, x5
               	cmp	x0, #0xc
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x64               // =100
               	add	x0, x1, x0
               	ret
               	mov	x0, #0x65               // =101
               	b	<addr>
               	mov	x0, #0x66               // =102
               	b	<addr>
               	mov	x0, #0x67               // =103
               	b	<addr>
               	mov	x0, #0x68               // =104
               	b	<addr>
               	mov	x0, #0x69               // =105
               	b	<addr>
               	mov	x0, #0x6a               // =106
               	b	<addr>
               	mov	x0, #0x6b               // =107
               	b	<addr>
               	mov	x0, #0x6c               // =108
               	b	<addr>
               	mov	x0, #0x6d               // =109
               	b	<addr>
               	mov	x0, #0x6e               // =110
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	b	<addr>
               	add	x3, x2, #0x8
               	b	<addr>
               	add	x3, x2, #0xf
               	b	<addr>
               	add	x3, x2, #0x16
               	b	<addr>
               	add	x3, x2, #0x1d
               	b	<addr>
               	add	x3, x2, #0x24
               	b	<addr>
               	add	x3, x2, #0x2b
               	b	<addr>
               	add	x3, x2, #0x32
               	b	<addr>
               	add	x3, x2, #0x39
               	b	<addr>
               	add	x3, x2, #0x40
               	b	<addr>
               	add	x3, x2, #0x47
               	b	<addr>
               	add	x3, x2, #0x4e
               	b	<addr>
               	mov	x5, #-0x1               // =-1
               	mov	x3, x5
               	b	<addr>
               	mov	x2, #0x6c               // =108
               	b	<addr>
               	mov	x2, #0x73               // =115
               	b	<addr>
               	mov	x2, #0x7a               // =122
               	b	<addr>
               	mov	x2, #0x81               // =129
               	b	<addr>
               	mov	x2, #0x88               // =136
               	b	<addr>
               	mov	x2, #0x8f               // =143
               	b	<addr>
               	mov	x2, #0x96               // =150
               	b	<addr>
               	mov	x2, #0x9d               // =157
               	b	<addr>
               	mov	x2, #0xa4               // =164
               	b	<addr>
               	mov	x2, #0xab               // =171
               	b	<addr>
               	mov	x2, #0xb2               // =178
               	b	<addr>
               	mov	x4, #-0x1               // =-1
               	mov	x2, x4
               	b	<addr>
               	mov	x1, #0x5                // =5
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0xb                // =11
               	b	<addr>
               	mov	x1, #0xe                // =14
               	b	<addr>
               	mov	x1, #0x11               // =17
               	b	<addr>
               	mov	x1, #0x14               // =20
               	b	<addr>
               	mov	x1, #0x17               // =23
               	b	<addr>
               	mov	x1, #0x1a               // =26
               	b	<addr>
               	mov	x1, #0x1d               // =29
               	b	<addr>
               	mov	x1, #0x20               // =32
               	b	<addr>
               	mov	x1, #0x23               // =35
               	b	<addr>
               	mov	x1, #0x3e8              // =1000
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #-0x2              // =-2
               	mov	x20, #-0x2              // =-2
               	add	x22, x21, #0x1
               	mov	x17, #0x7               // =7
               	mul	x0, x21, x17
               	add	x0, x0, #0x64
               	add	x0, x0, #0x1
               	sxtw	x23, w0
               	mov	x17, #0x7               // =7
               	mul	x0, x22, x17
               	sxtw	x25, w0
               	add	x24, x21, #0x64
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	cmp	w20, #0x0
               	b.lt	<addr>
               	cmp	w20, #0xc
               	b.ge	<addr>
               	add	x1, x20, x20, lsl #1
               	add	x1, x1, #0x2
               	sxtw	x3, w1
               	cmp	w21, #0x0
               	b.lt	<addr>
               	cmp	w21, #0xc
               	b.ge	<addr>
               	mov	x1, #0xc8               // =200
               	sub	x1, x1, x21
               	mov	x5, x23
               	cmp	w22, #0x0
               	b.lt	<addr>
               	cmp	w22, #0xc
               	b.ge	<addr>
               	add	x2, x5, x25
               	add	x4, x2, #0x1
               	sub	x2, x1, x22
               	mov	x17, #0x3e8             // =1000
               	mul	x5, x5, x17
               	add	x3, x3, x5
               	add	x1, x3, x1
               	mov	x17, #0xa               // =10
               	mul	x3, x4, x17
               	add	x1, x1, x3
               	add	x2, x1, x2
               	cmp	w21, #0x0
               	b.lt	<addr>
               	cmp	w21, #0xa
               	b.gt	<addr>
               	mov	x1, x24
               	add	x1, x2, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x4, x2
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x5, x1
               	b	<addr>
               	mov	x3, #0x3e8              // =1000
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0xf
               	b.lt	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0xf
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
