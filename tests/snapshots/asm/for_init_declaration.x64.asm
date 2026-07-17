
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<simple_sum>:
               	movl	$0x2d, %eax
               	retq

<multi_decl>:
               	movl	$0x32, %eax
               	retq

<adjacent_fors>:
               	movl	$0x2b, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x32, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2b, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x4, %edx
               	movl	$0x2, %esi
               	movl	%esi, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rax
               	leaq	<rip>, %rdx
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x4, %edx
               	movl	$0x2, %edi
               	movl	%edi, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	jmp	<addr>
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rax
               	leaq	<rip>, %rdx
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
