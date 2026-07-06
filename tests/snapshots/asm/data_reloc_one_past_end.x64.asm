
data_reloc_one_past_end.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	addq	$0x8, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
