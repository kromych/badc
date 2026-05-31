
bitfields.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$-0x2, %r9
               	movl	$0x1, %r8d
               	andq	$0x1, %r8
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	andq	$-0x3, %r9
               	xorq	%r11, %r11
               	andq	$0x1, %r11
               	shlq	$0x1, %r11
               	orq	%r11, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$-0x1d, %r9
               	movl	$0x5, %r8d
               	andq	$0x7, %r8
               	shlq	$0x2, %r8
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	andq	$-0x3e1, %r9            # imm = 0xFC1F
               	movl	$0x11, %r11d
               	andq	$0x1f, %r11
               	shlq	$0x5, %r11
               	orq	%r11, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r9d
               	movabsq	$-0x100000000, %r10     # imm = 0xFFFFFFFF00000000
               	andq	%r10, %r9
               	movl	$0x12345678, %r8d       # imm = 0x12345678
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x3e7, %r9d            # imm = 0x3E7
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$0x1, %r9
               	cmpq	$0x1, %r9
               	je	0x40034c <.text+0x11c>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x40037d <.text+0x14d>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	sarq	$0x2, %r9
               	andq	$0x7, %r9
               	cmpq	$0x5, %r9
               	je	0x4003aa <.text+0x17a>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x4003db <.text+0x1ab>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r9d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x12345678, %r9        # imm = 0x12345678
               	je	0x40040d <.text+0x1dd>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	0x40043a <.text+0x20a>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	andq	$-0x2, %r9
               	xorq	%r8, %r8
               	andq	$0x1, %r8
               	orq	%r8, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	0x400481 <.text+0x251>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x4004b2 <.text+0x282>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	sarq	$0x2, %r9
               	andq	$0x7, %r9
               	cmpq	$0x5, %r9
               	je	0x4004df <.text+0x2af>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x400510 <.text+0x2e0>
               	movl	$0xa, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r9d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x12345678, %r9        # imm = 0x12345678
               	je	0x400542 <.text+0x312>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	0x40056f <.text+0x33f>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	andq	$-0x1d, %r9
               	movl	$0x7, %r8d
               	andq	$0x7, %r8
               	shlq	$0x2, %r8
               	orq	%r8, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	sarq	$0x2, %r9
               	andq	$0x7, %r9
               	cmpq	$0x7, %r9
               	je	0x4005c1 <.text+0x391>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x4005f2 <.text+0x3c2>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	0x40061b <.text+0x3eb>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$-0x2, %rax
               	movl	$0x1, %r8d
               	andq	$0x1, %r8
               	orq	%r8, %rax
               	movl	%eax, (%r9)
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %eax
               	andq	$-0x3, %rax
               	movq	%r8, %r9
               	shlq	$0x1, %r9
               	orq	%r9, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$-0x5, %rax
               	xorq	%rdi, %rdi
               	andq	$0x1, %rdi
               	shlq	$0x2, %rdi
               	orq	%rdi, %rax
               	movl	%eax, (%r9)
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %eax
               	andq	$-0x9, %rax
               	shlq	$0x3, %r8
               	orq	%r8, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0xf1, %rax
               	movl	$0xb, %edi
               	andq	$0xf, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movl	$0xc8, %r8d
               	andq	$0xff, %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	0x400701 <.text+0x4d1>
               	movl	$0x10, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r8d
               	sarq	$0x1, %r8
               	andq	$0x1, %r8
               	cmpq	$0x1, %r8
               	je	0x40072e <.text+0x4fe>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	sarq	$0x2, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x40075f <.text+0x52f>
               	movl	$0x12, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r8d
               	sarq	$0x3, %r8
               	andq	$0x1, %r8
               	cmpq	$0x1, %r8
               	je	0x40078c <.text+0x55c>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xb, %rax
               	je	0x4007bd <.text+0x58d>
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r8d
               	sarq	$0x8, %r8
               	andq	$0xff, %r8
               	cmpq	$0xc8, %r8
               	je	0x4007ea <.text+0x5ba>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %r9d
               	sarq	$0x8, %r9
               	andq	$0xff, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	shlq	$0x8, %r9
               	orq	%r9, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc9, %rax
               	je	0x400856 <.text+0x626>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
