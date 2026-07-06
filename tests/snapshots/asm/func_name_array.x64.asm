
func_name_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
