
runtime_range_designator_struct.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<check_struct_ranges>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, (%rax)
               	movq	$0x9, 0x8(%rax)
               	leaq	0x10(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	0x20(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movl	$0x5, 0x30(%rax)
               	leaq	-0x40(%rbp), %rdx
               	movq	$0x6, 0x38(%rdx)
               	movslq	(%rcx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movslq	(%rcx), %rdi
               	cmpl	$0xd, %edi
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x30(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x38(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, 0x10(%rax)
               	movq	$0x9, 0x18(%rax)
               	leaq	0x20(%rax), %rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	0x30(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movl	$0x5, 0x40(%rax)
               	movq	$0x6, 0x48(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rdx)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	cmpl	$0x3, %eax
               	jg	<addr>
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movslq	(%rcx), %rdi
               	cmpl	$0xd, %edi
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	0x40(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x48(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, (%rax)
               	movq	$0x1, 0x8(%rax)
               	leaq	0x10(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	0x20(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0x11, 0x10(%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	$0x2, 0x18(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x68, %eax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movq	0x28(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	0x10(%rax), %rax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq

<check_member_range>:
               	leaq	<rip>, %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	retq
               	movq	%rcx, %rax
               	retq

<check_row_range>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movl	%eax, (%rdx)
               	leaq	-0x20(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movl	$0x1d, (%rcx)
               	movl	$0x5, 0x4(%rcx)
               	movq	(%rcx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	%rsi, 0x10(%rcx)
               	movslq	(%rdx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6a, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movslq	(%rcx), %rdi
               	cmpl	$0x1d, %edi
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	cmpl	$0x0, 0x18(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xd, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1d, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
