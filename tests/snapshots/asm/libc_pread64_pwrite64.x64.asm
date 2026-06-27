
libc_pread64_pwrite64.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x40(%rbp), %rbx
               	leaq	<rip>, %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x242, %esi            # imm = 0x242
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x10, %r12d
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorq	%r12, %r12
               	movl	$0x10, %r13d
               	movq	%r12, %rsi
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x68(%rbp), %rsi
               	movq	%r13, %rdx
               	movq	%r12, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0xa8(%rax), %rcx
               	movq	0x88(%rax), %r12
               	movslq	%ebx, %rdi
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %eax
               	movq	%rcx, %r8
               	movq	%rax, %rcx
               	callq	*%r8
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x10, %r13d
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x68(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%r12, %rax
               	movq	%r13, %rcx
               	callq	*%rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq

<__c5_sys_pread64>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	movq	0x20(%rbp), %rsi
               	movq	0x30(%rbp), %rdx
               	movq	0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq

<__c5_sys_pwrite64>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	movq	0x20(%rbp), %rsi
               	movq	0x30(%rbp), %rdx
               	movq	0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
