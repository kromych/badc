
unknown_size_struct_array_counts_what_its_fill_reaches.x64:	file format elf64-x86-64

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

<is>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	cmpl	%r12d, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<file_scope>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	0x14(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq

<block_scope>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x61, -0x30(%rbp)
               	movb	$0x62, -0x2f(%rbp)
               	movb	$0x0, -0x2e(%rbp)
               	movl	$0x7, -0x2c(%rbp)
               	movb	$0x64, -0x28(%rbp)
               	movb	$0x65, -0x27(%rbp)
               	movb	$0x0, -0x26(%rbp)
               	movl	$0x2, -0x24(%rbp)
               	leaq	-0x20(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	movb	$0x61, -0x20(%rbp)
               	movb	$0x62, -0x1f(%rbp)
               	movb	$0x0, -0x1e(%rbp)
               	movl	$0x1, -0x1c(%rbp)
               	movb	$0x64, -0x18(%rbp)
               	movb	$0x65, -0x17(%rbp)
               	movb	$0x0, -0x16(%rbp)
               	movl	$0x7, -0x14(%rbp)
               	leaq	-0x10(%rbp), %rbx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	movb	$0x61, -0x10(%rbp)
               	movb	$0x62, -0xf(%rbp)
               	movb	$0x0, -0xe(%rbp)
               	movl	$0x7, -0xc(%rbp)
               	movb	$0x64, -0x8(%rbp)
               	movb	$0x65, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movl	$0x2, -0x4(%rbp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	jmp	<addr>
