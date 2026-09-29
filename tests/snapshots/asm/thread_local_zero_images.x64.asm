
thread_local_zero_images.x64:	file format elf64-x86-64

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

<block>:
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0xc8, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0xe0, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xd8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xd0, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x40, %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x58, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0xc0, %rcx
               	movb	$0x1, 0x63(%rcx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x40, %rdx
               	movb	$0x2, 0x1f(%rdx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x20, %rsi
               	movl	$0x4, (%rsi)
               	movl	$0x9, 0xc(%rax)
               	movq	%fs:0x0, %rdi
               	addq	$-0xd8, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	movq	%fs:0x0, %rdi
               	addq	$-0xd0, %rdi
               	movslq	0x4(%rdi), %rdi
               	cmpl	$0x5, %edi
               	jne	<addr>
               	movq	%fs:0x0, %rdi
               	addq	$-0xe0, %rdi
               	movq	(%rdi), %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x3, %edi
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movsbq	0x63(%rcx), %rcx
               	movsbq	0x1f(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
