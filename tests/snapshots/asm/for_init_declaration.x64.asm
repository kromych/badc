
for_init_declaration.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movl	$0x4, %edx
               	movl	$0x2, %esi
               	movl	%esi, 0x4(%rcx)
               	movl	%edx, 0x8(%rcx)
               	movq	%rcx, %rdx
               	leaq	0xc(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jae	<addr>
               	movslq	(%rdx), %rsi
               	addq	%rsi, %rax
               	addq	$0x4, %rdx
               	leaq	0xc(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	leaq	<rip>, %r8
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movl	$0x4, %edx
               	movl	$0x2, %edi
               	movl	%edi, 0x4(%rcx)
               	movl	%edx, 0x8(%rcx)
               	movq	%rcx, %rdx
               	cmpq	%rsi, %rdx
               	jae	<addr>
               	movslq	(%rdx), %rdi
               	addq	%rdi, %rax
               	addq	$0x4, %rdx
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movslq	%eax, %rsi
               	movq	%r8, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
