
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
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	<rip>, %rdx
               	movl	%esi, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0x4, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x4, %esi
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	<rip>, %rdx
               	movl	%esi, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0x4, %rax
               	leaq	0xc(%rdx), %rsi
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
