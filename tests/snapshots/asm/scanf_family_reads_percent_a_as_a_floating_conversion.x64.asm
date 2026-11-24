
scanf_family_reads_percent_a_as_a_floating_conversion.x64:	file format elf64-x86-64

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

<scan_string>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<scan_file>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	subq	$0x48, %rsp
               	leaq	0x18(%rsp), %rax
               	movq	$0x0, (%rax)
               	leaq	0x20(%rsp), %rax
               	movq	$0x0, (%rax)
               	leaq	0x28(%rsp), %rax
               	movq	$0x0, (%rax)
               	leaq	0x30(%rsp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %rdx
               	leaq	0x38(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movss	0x18(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x38(%rsp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x20(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movss	0x20(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x28(%rsp), %rdx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movss	0x28(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x30(%rsp), %rdx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movss	0x30(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
