
static_local_shadows_global.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, (%rax)
               	cmpl	$0x11d7, %edx           # imm = 0x11D7
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, (%rax)
               	cmpl	$0x11d8, %edx           # imm = 0x11D8
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
