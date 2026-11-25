
thread_local_address_per_thread.x64:	file format elf64-x86-64

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

<thread_main>:
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movq	(%rdx), %rcx
               	leaq	<rip>, %rsi # <addr>
               	addq	$0x8, %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	retq
               	movq	$0x0, (%rax)
               	movq	$0x0, (%rdx)
               	movl	$0x63, %eax
               	retq

<main>:
               	subq	$0x38, %rsp
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %r11
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	*%r11
               	movq	0x20(%rsp), %rdi
               	movq	0x10(%rsp), %r11
               	leaq	0x28(%rsp), %rsi
               	callq	*%r11
               	movq	0x28(%rsp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x18(%rsp), %r11
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	*%r11
               	movq	0x20(%rsp), %rdi
               	movq	0x10(%rsp), %r11
               	leaq	0x28(%rsp), %rsi
               	callq	*%r11
               	movq	0x28(%rsp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
