
libc_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400808 <.text+0x148>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x178]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40074c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a6
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ad
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4011a8 <dlsym>
               	cbz	x0, 0x4007d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4007d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x4011b4 <strlen>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	0x400884 <.text+0x1c4>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1de
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x4011b4 <strlen>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4008d4 <.text+0x214>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1df
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e3
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4011c0 <strcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400934 <.text+0x274>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ee
               	mov	x21, x19
               	mov	x23, #0x3               // =3
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x4011cc <strncmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x40099c <.text+0x2dc>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f5
               	mov	x20, x19
               	mov	x23, #0x6c              // =108
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4011d8 <strchr>
               	cmp	x0, #0x0
               	b.ne	0x4009f4 <.text+0x334>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w23, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	b.eq	0x400a48 <.text+0x388>
               	mov	x23, #0x6               // =6
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1fb
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x4011e4 <strcpy>
               	sub	x20, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ff
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4011f0 <strcat>
               	sub	x21, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x203
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x4011c0 <strcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400ad8 <.text+0x418>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20a
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x4011e4 <strcpy>
               	sub	x0, x29, #0x80
               	add	x21, x0, #0x2
               	sub	x24, x29, #0x80
               	mov	x23, #0x5               // =5
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x4011fc <memmove>
               	sub	x0, x29, #0x80
               	add	x23, x0, #0x2
               	ldrb	w0, [x23]
               	mov	x17, #0x30              // =48
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	b.eq	0x400b6c <.text+0x4ac>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x80
               	add	x0, x23, #0x6
               	ldrb	w23, [x0]
               	mov	x17, #0x34              // =52
               	eor	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	b.eq	0x400bc8 <.text+0x508>
               	mov	x23, #0x9               // =9
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x215
               	mov	x20, x19
               	mov	x23, #0x7               // =7
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21e
               	mov	x24, x19
               	mov	x21, #0x2a              // =42
               	mov	x0, x22
               	mov	x4, x21
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x401208 <sprintf>
               	sxtw	x0, w0
               	sub	x25, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x221
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x4011c0 <strcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400c60 <.text+0x5a0>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x80
               	mov	x26, #0x10              // =16
               	adrp	x19, 0x410000
               	add	x19, x19, #0x229
               	mov	x21, x19
               	mov	x25, #0x63              // =99
               	mov	x0, x24
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x401214 <snprintf>
               	sxtw	x0, w0
               	sub	x20, x29, #0x80
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4011c0 <strcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400ce8 <.text+0x628>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x20              // =32
               	mov	x0, x21
               	bl	0x401220 <isspace>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x400d30 <.text+0x670>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x35              // =53
               	mov	x0, x23
               	bl	0x40122c <isdigit>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x400d78 <.text+0x6b8>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x61              // =97
               	mov	x0, x21
               	bl	0x40122c <isdigit>
               	sxtw	x0, w0
               	cbz	x0, 0x400dc0 <.text+0x700>
               	mov	x21, #0xe               // =14
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x51              // =81
               	mov	x0, x23
               	bl	0x401238 <isalpha>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x400e08 <.text+0x748>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x7a              // =122
               	mov	x0, x21
               	bl	0x401244 <isalnum>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x400e50 <.text+0x790>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x61              // =97
               	mov	x0, x23
               	bl	0x401250 <toupper>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.eq	0x400e98 <.text+0x7d8>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x5a              // =90
               	mov	x0, x21
               	bl	0x40125c <tolower>
               	sxtw	x0, w0
               	cmp	x0, #0x7a
               	b.eq	0x400ee0 <.text+0x820>
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x66              // =102
               	mov	x0, x23
               	bl	0x401268 <isxdigit>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x400f28 <.text+0x868>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22f
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x401274 <atoi>
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	0x400f78 <.text+0x8b8>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x232
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x401274 <atoi>
               	sxtw	x0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400fd8 <.text+0x918>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xfffb            // =65531
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x401280 <abs>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	0x40102c <.text+0x96c>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
