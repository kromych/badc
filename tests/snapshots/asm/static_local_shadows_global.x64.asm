
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
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, (%rcx)
               	cmpl	$0x11d7, %eax           # imm = 0x11D7
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, (%rcx)
               	cmpl	$0x11d8, %eax           # imm = 0x11D8
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rdx), %rax
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
