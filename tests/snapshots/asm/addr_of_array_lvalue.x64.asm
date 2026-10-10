
addr_of_array_lvalue.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leaq	<rip>, %rdx      # <addr>
               	addq	$0xc, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x2a, 0x5c(%rax)
               	movl	$0x7, 0x2c(%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	0xc(%rcx), %esi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	movl	0xc(%rcx), %esi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	0x5c(%rax), %ecx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movl	0x5c(%rax), %ecx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movl	0x5c(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	-0x10(%rbp), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	-0x18(%rbp), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	0x8(%rdx), %ecx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	movl	0x8(%rdx), %edx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movq	(%rcx), %rdx
               	movl	0xc(%rdx), %edx
               	cmpl	$0x4, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	(%rcx), %rcx
               	movl	0xc(%rcx), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	movl	0x5c(%rdx), %edx
               	cmpl	$0x2a, %edx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movl	0x2c(%rcx), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rcx, %rdx
               	sarq	$0x3, %rdx
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	0x5c(%rdx), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	leaq	0x8(%rcx), %rax
               	movl	0x4(%rax), %esi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	subq	%rcx, %rax
               	leaq	0xf(%rax), %rsi
               	andq	$-0x10, %rsi
               	cmpq	$0x10, %rsi
               	jne	<addr>
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rax
               	sarq	$0x2, %rax
               	addq	$0x3, %rax
               	andq	$-0x4, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	movl	(%rax), %edi
               	movq	(%rsi), %rsi
               	movl	(%rsi), %esi
               	addq	%rdi, %rsi
               	cmpl	$0x3, %esi
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	-0x38(%rbp), %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	0x5c(%rdx), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
