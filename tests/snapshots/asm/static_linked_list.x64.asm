
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
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	addq	$0x8, %rcx
               	leaq	<rip>, %rdx
               	movq	%rdx, (%rcx)
               	movl	$0x2, %eax
               	movl	%eax, (%rdx)
               	addq	$0x8, %rdx
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rdx)
               	movl	$0x3, %eax
               	movl	%eax, (%rcx)
               	addq	$0x8, %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	%edx, %rdx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
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
               	addb	%al, 0x41(%rdx)
