
thread_local_tentative_completed_later.x64:	file format elf64-x86-64

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

<tv_early>:
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x10(%rax)
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	cmpq	$0x0, 0x8(%rcx)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	movl	$0x0, (%rcx)
               	movq	0x8(%rax), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x30, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	$0x4, 0x8(%rax)
               	movq	%fs:0x0, %rdx
               	addq	$-0x48, %rdx
               	movq	%fs:0x0, %rsi
               	addq	$-0x38, %rsi
               	movb	$0x5, (%rsi)
               	movb	$0x5, (%rdx)
               	testb	$0xf, %al
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
