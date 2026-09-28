
string_memmem.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx
               	movl	$0x4, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0xb, %esi
               	movq	%rdi, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x2(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %esi
               	leaq	<rip>, %rdx
               	movl	$0x5, %ecx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
