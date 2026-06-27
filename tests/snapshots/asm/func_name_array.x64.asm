
func_name_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x5, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
