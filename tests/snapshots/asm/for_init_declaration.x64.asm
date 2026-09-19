
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
               	leaq	<rip>, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, (%rdx)
               	movl	$0x2, 0x4(%rdx)
               	movl	$0x4, 0x8(%rdx)
               	movq	%rdx, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jae	<addr>
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0x4, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jb	<addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, (%rdx)
               	movl	$0x2, 0x4(%rdx)
               	movl	$0x4, 0x8(%rdx)
               	movq	%rdx, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jae	<addr>
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0x4, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movslq	%ecx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
