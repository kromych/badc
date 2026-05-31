
bitfields.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$-0x2, %r9
               	movl	$0x1, %r8d
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	andq	$-0x3, %r9
               	xorq	%r11, %r11
               	orq	%r11, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$-0x1d, %r9
               	movl	$0x14, %r8d
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	andq	$-0x3e1, %r9            # imm = 0xFC1F
               	movl	$0x220, %r11d           # imm = 0x220
               	orq	%r11, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r9d
               	movabsq	$-0x100000000, %r10     # imm = 0xFFFFFFFF00000000
               	andq	%r10, %r9
               	movl	$0x12345678, %r8d       # imm = 0x12345678
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x3e7, %r9d            # imm = 0x3E7
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x1, %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x2, %r11
               	andq	$0x7, %r11
               	cmpq	$0x5, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x5, %r11
               	andq	$0x1f, %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r11d
               	cmpq	$0x12345678, %r11       # imm = 0x12345678
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x3e7, %r11            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x2, %rax
               	xorq	%r8, %r8
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r8d
               	andq	$0x1, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x1, %r8
               	andq	$0x1, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x2, %r8
               	andq	$0x7, %r8
               	cmpq	$0x5, %r8
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x5, %r8
               	andq	$0x1f, %r8
               	cmpq	$0x11, %r8
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movl	(%r8), %r8d
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x3e7, %r8             # imm = 0x3E7
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x1d, %rax
               	movl	$0x1c, %r11d
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x2, %r11
               	andq	$0x7, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x5, %r11
               	andq	$0x1f, %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x2, %rax
               	movl	$0x1, %r8d
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x3, %rax
               	movl	$0x2, %r11d
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x5, %rax
               	xorq	%r8, %r8
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x9, %rax
               	movl	$0x8, %r11d
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0xf1, %rax
               	movl	$0xb0, %r8d
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movl	$0xc800, %r11d          # imm = 0xC800
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x1, %r11
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x2, %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x3, %r11
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x4, %r11
               	andq	$0xf, %r11
               	cmpq	$0xb, %r11
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x8, %r11
               	andq	$0xff, %r11
               	cmpq	$0xc8, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x8, %r8
               	andq	$0xff, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	andq	$0xff, %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	sarq	$0x8, %r8
               	andq	$0xff, %r8
               	cmpq	$0xc9, %r8
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
