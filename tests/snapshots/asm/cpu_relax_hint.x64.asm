
cpu_relax_hint.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	jmp	<addr>
               	pause
               	pause
               	pause
               	pause
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
