
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
               	movl	$0x4, %edx
               	movl	$0x2, %esi
               	movl	%esi, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rax
               	leaq	<rip>, %rdx
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x4, %edx
               	movl	$0x2, %edi
               	movl	%edi, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rax
               	leaq	<rip>, %rdx
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movslq	%ecx, %rax
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
