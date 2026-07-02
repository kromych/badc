
data_reloc_one_past_end.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movq	(%rcx), %rax
               	addq	%rax, %rdx
               	addq	$0x8, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
