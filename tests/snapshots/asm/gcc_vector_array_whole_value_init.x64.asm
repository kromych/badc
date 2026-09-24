
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x4a0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
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
               	addq	$0x20, %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x29, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rax), %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	(%rdx), %rax
               	xorq	$0x15, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x470(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	movzbq	0xf(%rdx), %rdx
               	xorq	$0x24, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	addq	$0x20, %rax
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
               	leaq	-0x4d0(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x4b0(%rbp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	(%rcx), %rdx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
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
               	leaq	-0x4d0(%rbp), %rdx
               	leaq	0x10(%rcx), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	0x7(%rcx), %rcx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x4c0(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	(%rax), %rax
               	xorq	$0x15, %rax
               	testl	%eax, %eax
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	(%rax), %rax
               	xorq	$0x29, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x9(%rcx), %rax
               	xorq	$0x32, %rax
               	testl	%eax, %eax
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x4c0(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x4b0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x30(%rax), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x4b0(%rbp), %rcx
               	addq	$0x30, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	-0x300(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x4d0(%rbp), %rcx
               	leaq	0x50(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	(%rax), %rsi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	0x20(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	addq	$0x30, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x29, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	(%rdx), %rax
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, 0x10(%rax)
               	leaq	-0x4c0(%rbp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
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
