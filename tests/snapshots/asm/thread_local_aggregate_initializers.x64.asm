
thread_local_aggregate_initializers.x64:	file format elf64-x86-64

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

<seven>:
               	movl	$0x7, %eax
               	retq

<counter>:
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %eax
               	addq	%rcx, %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x20, %rcx
               	movq	0x8(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	retq

<first>:
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	(%rax), %ecx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, (%rax)
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0xa0, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x90, %rax
               	movl	0x8(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x80, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x73, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x60, %rax
               	movsbq	0x3(%rax), %rcx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movsd	0x18(%rax), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsbq	0x11(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0x99, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x9a, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0xa0, %rcx
               	xorl	%edx, %edx
               	movl	$0x64, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x80, %rcx
               	movl	$0x64, (%rcx)
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x8(%rax)
               	movq	%rdx, %rax
               	popq	%rbp
               	retq

<thread_main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xa, %rax
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xa0, %rax
               	movl	(%rax), %eax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x80, %rax
               	movl	(%rax), %eax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movsd	0x8(%rax), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
