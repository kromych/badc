
cast_fn_ptr_named_param_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<inc>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	callq	*%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq

<via_typedef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	leaq	-<rip>, %rax       # <addr>
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0xa, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x14, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	cmpq	$0xb, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x15, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
