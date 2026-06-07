
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edx, %rdx
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x7, %ebx
               	cmpq	$0x7, %rbx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x13, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rbx, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x14, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
