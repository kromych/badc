
static_local_shadows_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, (%rax)
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11d7, %rax           # imm = 0x11D7
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, (%rax)
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11d8, %rax           # imm = 0x11D8
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rdx), %rax
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
