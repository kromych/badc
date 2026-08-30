
struct_stat_abi_size.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xa8(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movzbq	0x10(%rax), %rcx
               	movb	%cl, 0x10(%rdi)
               	movzbq	0x11(%rax), %rcx
               	movb	%cl, 0x11(%rdi)
               	movzbq	0x12(%rax), %rcx
               	movb	%cl, 0x12(%rdi)
               	movzbq	0x13(%rax), %rcx
               	movb	%cl, 0x13(%rdi)
               	movzbq	0x14(%rax), %rcx
               	movb	%cl, 0x14(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x90, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	0x30(%rax), %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x18(%rax), %rax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
