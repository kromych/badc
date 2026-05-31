
array_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
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
               	leaq	<rip>, %r9
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
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x38(%rbp), %r8
               	leaq	<rip>, %r9
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
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x4, %r9
               	movzbq	(%r9), %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
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
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rdi
               	xorq	$0x68, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	addq	$0xf, %rdi
               	movzbq	(%rdi), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x10, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x11, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdi
               	addq	$0x4, %rdi
               	movzbq	(%rdi), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
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
               	je	<addr>
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
               	je	<addr>
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
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
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
               	je	<addr>
               	movl	$0x17, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
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
               	je	<addr>
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
               	je	<addr>
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
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1c, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x12c, %rdi            # imm = 0x12C
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1e, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
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
               	je	<addr>
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
               	je	<addr>
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
