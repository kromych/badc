
posix_timers_and_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<doubled>:
               	leaq	(%rdi,%rdi), %rax
               	retq

<declared_only>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	subq	$0x188, %rsp            # imm = 0x188
               	movq	<rip>, %rax # <addr>
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x29, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movl	$0x0, 0x10(%rsp)
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movl	0x10(%rsp), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x7a, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movsbq	0x18(%rsp), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x98(%rsp), %rdx
               	movq	$0x0, 0x98(%rsp)
               	movq	$0x0, 0xa0(%rsp)
               	movq	$0x0, 0xa8(%rsp)
               	movq	$0x0, 0xb0(%rsp)
               	movq	$0x0, 0xb8(%rsp)
               	movq	$0x0, 0xc0(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movl	0xac(%rsp), %eax
               	cmpl	$0x7c, %eax
               	jne	<addr>
               	movl	0xa8(%rsp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	0xa4(%rsp), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x20(%rsp), %rax
               	movw	$0x6968, 0x20(%rsp)     # imm = 0x6968
               	movq	%rax, 0x30(%rsp)
               	leaq	0x28(%rsp), %rax
               	movq	%rax, 0x38(%rsp)
               	movq	$0x2, 0x40(%rsp)
               	movq	$0x8, 0x48(%rsp)
               	leaq	0x30(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	leaq	0x38(%rsp), %rcx
               	leaq	0x48(%rsp), %r8
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rdi
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	cmpq	$0x0, 0x40(%rsp)
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movsbq	0x28(%rsp), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movsbq	0x29(%rsp), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0xd0(%rsp), %rsi
               	movq	$0x0, 0xd0(%rsp)
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movq	$0x0, 0xe0(%rsp)
               	movq	$0x0, 0xe8(%rsp)
               	movq	$0x0, 0xf0(%rsp)
               	movq	$0x0, 0xf8(%rsp)
               	movq	$0x0, 0x100(%rsp)
               	movq	$0x0, 0x108(%rsp)
               	movl	$0x1, %edi
               	movq	%rcx, 0xd8(%rsp)
               	leaq	0x50(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x58(%rsp), %rdx
               	xorl	%esi, %esi
               	movq	%rsi, 0x58(%rsp)
               	movq	%rsi, 0x60(%rsp)
               	movq	$0xe10, 0x68(%rsp)      # imm = 0xE10
               	movq	%rsi, 0x70(%rsp)
               	movq	0x50(%rsp), %rdi
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x78(%rsp), %rsi
               	movq	$0x0, 0x78(%rsp)
               	movq	$0x0, 0x80(%rsp)
               	movq	$0x0, 0x88(%rsp)
               	movq	$0x0, 0x90(%rsp)
               	movq	0x50(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movq	0x88(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	cmpq	$0xe10, %rax            # imm = 0xE10
               	jle	<addr>
               	movl	$0x12, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movq	0x50(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movq	0x50(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	0x110(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movq	0x110(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x0, 0x130(%rsp)
               	je	<addr>
               	cmpl	$0x0, 0x178(%rsp)
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jl	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	jge	<addr>
               	movl	$0x17, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	movl	$0xfa, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xf9, %edi
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rcx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	movl	$0x18, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	xorl	%eax, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
