
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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
               	subq	$0x4d0, %rsp            # imm = 0x4D0
               	leaq	-0x4d0(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x4a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x4a0(%rbp), %rax
               	movzbq	0xf(%rax), %rcx
               	xorq	$0x10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x15, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x24, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x29, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x38, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x470(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x4d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4c0(%rbp), %rsi
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4b0(%rbp), %rdx
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movzbq	(%rax), %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rax), %rdx
               	xorq	$0x10, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	(%rcx), %rax
               	xorq	$0x15, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x470(%rbp), %rcx
               	leaq	0x10(%rcx), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x24, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	0x20(%rcx), %rax
               	movzbq	(%rax), %rdx
               	xorq	$0x29, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x38, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x440(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x4d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4b0(%rbp), %rdx
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movzbq	(%rax), %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x38, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x3e0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movb	$0x7, (%rcx)
               	movb	$0x7, 0x1(%rcx)
               	movb	$0x7, 0x2(%rcx)
               	movb	$0x7, 0x3(%rcx)
               	movb	$0x7, 0x4(%rcx)
               	movb	$0x7, 0x5(%rcx)
               	leaq	-0x3e0(%rbp), %rcx
               	movb	$0x7, 0x6(%rcx)
               	movb	$0x7, 0x7(%rcx)
               	movb	$0x7, 0x8(%rcx)
               	movb	$0x7, 0x9(%rcx)
               	movb	$0x7, 0xa(%rcx)
               	movb	$0x7, 0xb(%rcx)
               	movb	$0x7, 0xc(%rcx)
               	leaq	-0x3e0(%rbp), %rcx
               	movb	$0x7, 0xd(%rcx)
               	movb	$0x7, 0xe(%rcx)
               	movb	$0x7, 0xf(%rcx)
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	0x10(%rcx), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rdx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movzbq	(%rax), %rax
               	xorq	$0x15, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x3e0(%rbp), %rax
               	addq	$0x10, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x24, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x3c0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movb	$0x3, (%rcx)
               	movb	$0x3, 0x1(%rcx)
               	movb	$0x3, 0x2(%rcx)
               	movb	$0x3, 0x3(%rcx)
               	movb	$0x3, 0x4(%rcx)
               	movb	$0x3, 0x5(%rcx)
               	leaq	-0x3c0(%rbp), %rcx
               	movb	$0x3, 0x6(%rcx)
               	movb	$0x3, 0x7(%rcx)
               	movb	$0x3, 0x8(%rcx)
               	movb	$0x3, 0x9(%rcx)
               	movb	$0x3, 0xa(%rcx)
               	movb	$0x3, 0xb(%rcx)
               	movb	$0x3, 0xc(%rcx)
               	leaq	-0x3c0(%rbp), %rcx
               	movb	$0x3, 0xd(%rcx)
               	movb	$0x3, 0xe(%rcx)
               	movb	$0x3, 0xf(%rcx)
               	leaq	-0x4d0(%rbp), %rsi
               	leaq	0x10(%rcx), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movzbq	0x7(%rcx), %rdx
               	xorq	$0x3, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x3a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4c0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movzbq	(%rax), %rdx
               	xorq	$0x15, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x370(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x4b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	0x20(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movzbq	(%rax), %rsi
               	xorq	$0x29, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0x9(%rcx), %rcx
               	xorq	$0x32, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rdx), %rax
               	xorq	$0x38, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x340(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	-0x4d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	0x30(%rax), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x340(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x15, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x29, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	addq	$0x30, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x300(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	leaq	-0x4d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4b0(%rbp), %rcx
               	addq	$0x30, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	-0x300(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x4d0(%rbp), %rsi
               	leaq	0x50(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movzbq	(%rax), %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	0x20(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x29, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	0x30(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x29, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x2a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movl	$0x5, 0x10(%rax)
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	0x20(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movl	$0x6, 0x30(%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x2a0(%rbp), %rax
               	addq	$0x20, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x24, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xf(%rax)
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x16, %eax
               	leave
               	retq
