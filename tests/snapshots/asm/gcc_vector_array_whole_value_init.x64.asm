
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
               	addq	$0x0, %rax
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
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
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
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
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
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0xf(%rax), %rsi
               	xorq	$0x10, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	(%rcx), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x15, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x470(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x24, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rcx
               	leaq	(%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
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
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
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
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
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
               	movl	$0x7, %eax
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	leaq	-0x3e0(%rbp), %rcx
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x3e0(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	0x10(%rcx), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
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
               	addq	$0x0, %rax
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
               	movl	$0x3, %eax
               	movb	%al, (%rcx)
               	movb	%al, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%al, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	%al, 0x5(%rcx)
               	leaq	-0x3c0(%rbp), %rcx
               	movb	%al, 0x6(%rcx)
               	movb	%al, 0x7(%rcx)
               	movb	%al, 0x8(%rcx)
               	movb	%al, 0x9(%rcx)
               	movb	%al, 0xa(%rcx)
               	movb	%al, 0xb(%rcx)
               	movb	%al, 0xc(%rcx)
               	leaq	-0x3c0(%rbp), %rcx
               	movb	%al, 0xd(%rcx)
               	movb	%al, 0xe(%rcx)
               	movb	%al, 0xf(%rcx)
               	leaq	-0x4d0(%rbp), %rdx
               	leaq	0x10(%rcx), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movzbq	0x7(%rcx), %rsi
               	xorq	$0x3, %rsi
               	testl	%esi, %esi
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
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4c0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x15, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	(%rcx), %rax
               	movzbq	(%rax), %rax
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
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
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
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x340(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	addq	$0x0, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x15, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rcx
               	addq	$0x0, %rcx
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
               	leaq	-0x4d0(%rbp), %rcx
               	leaq	0x50(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	0x20(%rax), %rsi
               	addq	$0x0, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	0x30(%rax), %rsi
               	addq	$0x0, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	(%rdx), %rax
               	movzbq	(%rax), %rax
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
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	0x20(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
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
               	addq	$0x10, %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	testq	%rax, %rax
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
