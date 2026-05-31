
array_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0xff11(%rip), %r9       # 0x41015e
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	movzbq	0x4(%r9), %rax
               	movb	%al, 0x4(%r11)
               	movzbq	0x5(%r9), %rax
               	movb	%al, 0x5(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x18(%rbp), %r8
               	leaq	0xfed3(%rip), %r9       # 0x410164
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%r9), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%r9), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	-0x20(%rbp), %r11
               	leaq	0xfea8(%rip), %r9       # 0x410173
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x38(%rbp), %r8
               	leaq	0xfe9a(%rip), %r9       # 0x41017b
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r8)
               	movzbq	0x10(%r9), %rax
               	movb	%al, 0x10(%r8)
               	movzbq	0x11(%r9), %rax
               	movb	%al, 0x11(%r8)
               	movzbq	0x12(%r9), %rax
               	movb	%al, 0x12(%r8)
               	movzbq	0x13(%r9), %rax
               	movb	%al, 0x13(%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	0xfdb7(%rip), %r11      # 0x4100d6
               	movzbq	(%r11), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40034e <.text+0x12e>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd81(%rip), %r9       # 0x4100d6
               	addq	$0x4, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40038f <.text+0x16f>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd40(%rip), %rax      # 0x4100d6
               	addq	$0x5, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4003c5 <.text+0x1a5>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	0x4003e3 <.text+0x1c3>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcf6(%rip), %r9       # 0x4100e0
               	movslq	(%r9), %rax
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%r9, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movq	%r9, %r8
               	addq	$0xc, %r8
               	movslq	(%r8), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1c, %rax
               	je	0x400454 <.text+0x234>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400475 <.text+0x255>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc7c(%rip), %rax      # 0x4100f8
               	movzbq	(%rax), %rdi
               	xorq	$0x68, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4004ab <.text+0x28b>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc46(%rip), %rdi      # 0x4100f8
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4004eb <.text+0x2cb>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc06(%rip), %rax      # 0x4100f8
               	addq	$0x2, %rax
               	movzbq	(%rax), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400521 <.text+0x301>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbd0(%rip), %rdi      # 0x4100f8
               	addq	$0xf, %rdi
               	movzbq	(%rdi), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40055a <.text+0x33a>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x40057b <.text+0x35b>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb8e(%rip), %rax      # 0x410110
               	movslq	(%rax), %rdi
               	cmpq	$0x1, %rdi
               	je	0x4005a0 <.text+0x380>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb69(%rip), %rdi      # 0x410110
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x3, %rax
               	je	0x4005cf <.text+0x3af>
               	movl	$0xd, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb3a(%rip), %rax      # 0x410110
               	addq	$0xc, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	0x4005fb <.text+0x3db>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb0e(%rip), %rdi      # 0x410110
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	0x40062a <.text+0x40a>
               	movl	$0xf, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb0f(%rip), %rax      # 0x410140
               	movq	(%rax), %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400666 <.text+0x446>
               	movl	$0x10, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfad3(%rip), %rax      # 0x410140
               	addq	$0x8, %rax
               	movq	(%rax), %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4006a9 <.text+0x489>
               	movl	$0x11, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa90(%rip), %rax      # 0x410140
               	addq	$0x10, %rax
               	movq	(%rax), %rdi
               	addq	$0x4, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4006f3 <.text+0x4d3>
               	movl	$0x12, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdi
               	xorq	$0x77, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400726 <.text+0x506>
               	movl	$0x13, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x4, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400763 <.text+0x543>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400796 <.text+0x576>
               	movl	$0x15, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4007b4 <.text+0x594>
               	movl	$0x16, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rax
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	je	0x400801 <.text+0x5e1>
               	movl	$0x17, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400822 <.text+0x602>
               	movl	$0x18, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rdi
               	xorq	$0x6f, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400855 <.text+0x635>
               	movl	$0x19, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x6b, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400892 <.text+0x672>
               	movl	$0x1a, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4008c5 <.text+0x6a5>
               	movl	$0x1b, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x64, %rax
               	je	0x4008ea <.text+0x6ca>
               	movl	$0x1c, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x12c, %rdi            # imm = 0x12C
               	je	0x400913 <.text+0x6f3>
               	movl	$0x1d, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	0x40093f <.text+0x71f>
               	movl	$0x1e, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	0x400968 <.text+0x748>
               	movl	$0x1f, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40099e <.text+0x77e>
               	movl	$0x20, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x7, %rax
               	movzbq	(%rax), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4009d1 <.text+0x7b1>
               	movl	$0x21, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
