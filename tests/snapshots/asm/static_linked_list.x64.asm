
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x2, %eax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x3, %eax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	%edx, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rdx
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
